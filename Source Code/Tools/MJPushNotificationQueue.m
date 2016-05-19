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

    if ([_delegate respondsToSelector:@selector(pushNotificationQueue:actionForPushNotification:completionHandler:)])
    {
        [_delegate pushNotificationQueue:self actionForPushNotification:userInfo completionHandler:^(MJPushNotificationAction action, UIBackgroundFetchResult fetchResult) {
            if (completionHandler)
            {
                completionHandler(fetchResult);
            }
            
            if (deliverNotification)
            {
                [self pw_handleNotification:userInfo withAction:action];
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
            [self pw_handleNotification:userInfo withAction:action];
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

- (void)pw_handleNotification:(NSDictionary*)userInfo withAction:(MJPushNotificationAction)action
{
    if (action == MJPushNotificationActionQueue)
    {
        [_operationQueue addOperationWithBlock:^{
            [self pw_processPush:userInfo];
        }];
    }
    else if (action == MJPushNotificationActionIgnore)
    {
        // Nothing to be done. Ignoring the push notification.
    }
    else if (action == MJPushNotificationActionProcess)
    {
        [self pw_processPush:userInfo];
    }
}

- (void)pw_processPush:(NSDictionary*)userInfo
{
    if ([_delegate respondsToSelector:@selector(pushNotificationQueue:didReceiveNotification:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           [_delegate pushNotificationQueue:self didReceiveNotification:userInfo]; 
        });
    }
}

@end
