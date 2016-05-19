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


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MJPushNotificationAction)
{
    MJPushNotificationActionQueue,
    MJPushNotificationActionIgnore,
    MJPushNotificationActionProcess,
};

typedef NS_ENUM(NSUInteger, MJPushNotificationDelivery)
{
    MJPushNotificationDeliveryNever                 = 0,
    MJPushNotificationDeliveryApplicationBackground = 1 << 0,
    MJPushNotificationDeliveryApplicationInactive   = 1 << 1,
    MJPushNotificationDeliveryApplicationActive     = 1 << 2,
    MJPushNotificationDeliveryAlways                = ~0LU,
};

@protocol MJPushNotificationQueueDelegate;

/**
 * A MJPushNotificationQueue.
 **/
@interface MJPushNotificationQueue : NSObject

/**
 * Adds a new push notification to process. This method should be invoked from the `application:didReceiveRemoteNotification:` from the application delegate.
 * @param userInfo The remote notification dictionary.
 **/
- (void)addNotification:(NSDictionary*)userInfo;

/**
 * Adds a new push notification to process. This method should be invoked from the `application:didReceiveRemoteNotification:fetchCompletionHandler:` from the application delegate.
 * @param userInfo The remote notification dictionary.
 * @param completionHandler The completion handler.
 **/
- (void)addNotification:(NSDictionary*)userInfo completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/**
 * Deliver notifications to the delegate object only if the application state matches the specified one. Default value set to `MJPushNotificationDeliveryApplicationInactive`.
 **/
@property (nonatomic, assign) MJPushNotificationDelivery delivery;

/**
 * Enalbe notifications to be processed in the queue. If not paused, notifications are queued waiting to be executed.
 **/
- (void)start;

/**
 * Pauses the notification processing queue.
 **/
- (void)pause;

/**
 * Clear all queued notifications.
 **/
- (void)clear;

/**
 * Boolean indicating if the queue is active or not (paused or not).
 **/
@property (nonatomic, assign, readonly, getter=isActive) BOOL active;

/**
 * The delegate object.
 **/
@property (nonatomic, weak) id <MJPushNotificationQueueDelegate> delegate;

@end

#pragma mark

/**
 * Push notification stack delegate protocol.
 **/
@protocol MJPushNotificationQueueDelegate <NSObject>

@optional

/**
 * Called before queuing the notification to the main queue. Depending on the action returned the notification will be ignored, queued or processed.
 * @param queue The notification queue.
 * @param userInfo The remote notification.
 * @return The desired action.
 * @discussion This method is called only if 'pushNotificationQueue:actionForPushNotification:completionHandler` is not implemented.
 **/
- (MJPushNotificationAction)pushNotificationQueue:(MJPushNotificationQueue*)queue actionForPushNotification:(NSDictionary*)userInfo;

/**
 * Called before queuing the notification to the main queue. Depending on the action returned the notification will be ignored, queued or processed.
 * @param queue The notification queue.
 * @param userInfo The remote notification.
 * @param completionHandler The completion handler containing the fetch result and the desired action.
 **/
- (void)pushNotificationQueue:(MJPushNotificationQueue*)queue actionForPushNotification:(NSDictionary*)userInfo completionHandler:(void (^)(MJPushNotificationAction action, UIBackgroundFetchResult fetchResult))completionHandler;

/**
 * Tells the delegate that a new notification has been received.
 * @param queue The notification queue.
 * @param userInfo The remote notification.
 **/
- (void)pushNotificationQueue:(MJPushNotificationQueue*)queue didReceiveNotification:(NSDictionary*)userInfo;

@end
