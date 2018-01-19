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
 * AlertView completion block type.
 * The completion block contains the following parameters:
 * @param alertView The invloved alert view.
 * @param buttonIndex The selected button index.
 */
typedef void (^UIAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

#pragma GCC diagnostic pop

/*!
 * This category adds support for completion blocks in the 'show' methods of alert view.
 */
@interface UIAlertView (Blocks) <UIAlertViewDelegate>

/*!
 * Use this method to show the alert view if you want to handle the response using a completion block.
 * @param completionBlock The completion block.
 */
- (void)showWithCompletionBlock:(UIAlertViewCompletionBlock)completionBlock;

@end
