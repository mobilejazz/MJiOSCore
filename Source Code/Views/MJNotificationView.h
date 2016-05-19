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

typedef NS_ENUM(NSUInteger, MJNotificationViewUserInteraction)
{
    MJNotificationViewUserInteractionNone,
    MJNotificationViewUserInteractionDismiss,
    MJNotificationViewUserInteractionTap,
};

/**
 * This class handles notification views and displays them into the key window.
 * 
 * - Only one notification at a time can be displayed. Multiple notifications are enqueued and displayed one after the other.
 * - Use the view's tintColor property to set the alert color (default value is purple).
 *
 **/
@interface MJNotificationView : UIView

/**
 * Default initializer.
 * @param text The text to display.
 **/
- (id)initWithText:(NSString*)text;

/**
 * The text to display.
 **/
@property (nonatomic, strong, readonly) NSString *text;

/**
 * Used text attributes.
 **/
@property (nonatomic, strong, readonly) NSDictionary *textAttributes;

/**
 * Custom user info.
 **/
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 * Show the alert.
 **/
- (void)show;

/**
 * Show the alert.
 * @param dismissBlock The dismissBlock.
 **/
- (void)showWithDismissBlock:(void(^)(MJNotificationViewUserInteraction userInteraction, NSDictionary *userInfo))completionBlock;

/**
 * Clear the list of notifications to be shown.
 **/
+ (void)clearShowQueue;

@end
