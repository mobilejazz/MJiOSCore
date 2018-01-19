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

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

/*!
 * ActionSheet completion block type.
 * The completion block contains the following parameters:
 * @param actionSheet The invloved action sheet.
 * @param buttonIndex The selected button index.
 */
typedef void(^UIActionSheetCompletionBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex);

#pragma GCC diagnostic pop

/*!
 * This category adds support for completion blocks in the 'show' methods of action sheet.
 */
@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

/*!
 * Call this method if you planned to call '-showInView:' method and you wanted to have a completion block.
 * @param view The view from which the action sheet originates.
 * @param block The completion block.
 */
- (void)showInView:(UIView *)view completionBlock:(UIActionSheetCompletionBlock)block;

/*!
 * Call this method if you planned to call '-showFromBarButtonItem:' method and you wanted to have a completion block.
 * @param item The bar button item from which the action sheet originates.
 * @param animated Specify YES to animate the presentation of the action sheet or NO to present it immediately without any animation effects.
 * @param block The completion block.
 */
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated completionBlock:(UIActionSheetCompletionBlock)block;

/*!
 * Call this method if you planned to call '-showFromRect:inView:animated:' method and you wanted to have a completion block.
 * @param rect The portion of view from which to originate the action sheet.
 * @param view The view from which to originate the action sheet.
 * @param animated Specify YES to animate the presentation of the action sheet or NO to present it immediately without any animation effects.
 * @param block The completion block.
 */
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated completionBlock:(UIActionSheetCompletionBlock)block;

/*!
 * Call this method if you planned to call '-showFromTabBar:' method and you wanted to have a completion block.
 * @param tabBar The tab bar from which the action sheet originates.
 * @param block The completion block.
 */
- (void)showFromTabBar:(UITabBar *)tabBar completionBlock:(UIActionSheetCompletionBlock)block;

/*!
 * Call this method if you planned to call '-showFromToolbar:' method and you wanted to have a completion block.
 * @param toolbar The toolbar from which the action sheet originates.
 * @param block The completion block.
 */
- (void)showFromToolbar:(UIToolbar *)toolbar completionBlock:(UIActionSheetCompletionBlock)block;

@end
