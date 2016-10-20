//
// Copyright 2014 Mobile Jazz SL
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "MJPushNotificationQueue.h"

@interface MJPushNotificationQueueItem : NSObject

@property (nonatomic, assign) UIApplicationState applicationState;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation MJPushNotificationQueueItem

@end


@implementation MJPushNotificationQueue
{
    NSOperationQueue *_operationQueue;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        _operationQueue.suspended = YES;
        
        _delivery = MJPushNotificationDeliveryApplicationInactive;
    }
    return self;
}

#pragma mark Public Methods

- (void)addNotification:(NSDictionary*)userInfo
{
    [self addNotification:userInfo completionHandler:nil];
}

- (void)addNotification:(NSDictionary*)userInfo completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    BOOL deliverNotification = NO;
    
    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
    
    if (applicationState == UIApplicationStateActive)
    {
        deliverNotification = (_delivery & MJPushNotificationDeliveryApplicationActive) != 0;
    }
    else if (applicationState == UIApplicationStateInactive)
    {
        deliverNotification = (_delivery & MJPushNotificationDeliveryApplicationInactive) != 0;
    }
    else if (applicationState == UIApplicationStateBackground)
    {
        deliverNotification = (_delivery & MJPushNotificationDeliveryApplicationBackground) != 0;
    }
    
    MJPushNotificationQueueItem *item = [[MJPushNotificationQueueItem alloc] init];
    item.applicationState = applicationState;
    item.userInfo = userInfo;
    item.date = [NSDate date];
    
    if ([_delegate respondsToSelector:@selector(pushNotificationQueue:actionForPushNotification:completionHandler:)])
    {
        [_delegate pushNotificationQueue:self actionForPushNotification:userInfo completionHandler:^(MJPushNotificationAction action, UIBackgroundFetchResult fetchResult) {
            if (completionHandler)
            {
                completionHandler(fetchResult);
            }
            
            if (deliverNotification)
            {
                [self pw_handleNotification:item withAction:action];
            }
        }];
    }
    else
    {
        MJPushNotificationAction action = MJPushNotificationActionQueue;
        
        if ([_delegate respondsToSelector:@selector(pushNotificationQueue:actionForPushNotification:)])
        {
            action = [_delegate pushNotificationQueue:self actionForPushNotification:userInfo];
        }
        
        if (deliverNotification)
        {
            [self pw_handleNotification:item withAction:action];
        }
    }
}

- (void)start
{
    _operationQueue.suspended = NO;
}

- (void)pause
{
    _operationQueue.suspended = YES;
}

- (void)clear
{
    [_operationQueue cancelAllOperations];
}

#pragma mark Private Methods

- (void)pw_handleNotification:(MJPushNotificationQueueItem*)item withAction:(MJPushNotificationAction)action
{
    if (action == MJPushNotificationActionQueue)
    {
        [_operationQueue addOperationWithBlock:^{
            [self pw_processPush:item];
        }];
    }
    else if (action == MJPushNotificationActionIgnore)
    {
        // Nothing to be done. Ignoring the push notification.
    }
    else if (action == MJPushNotificationActionProcess)
    {
        [self pw_processPush:item];
    }
}

- (void)pw_processPush:(MJPushNotificationQueueItem*)item
{
    if ([_delegate respondsToSelector:@selector(pushNotificationQueue:didReceiveNotification:inApplicationState:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate pushNotificationQueue:self didReceiveNotification:item.userInfo inApplicationState:item.applicationState];
        });
    }
}

@end
