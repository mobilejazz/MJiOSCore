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

@protocol MJTextViewCellDelegate;

/**
 * Default cell identifier (to be used optionally).
 **/
extern NSString * const MJTextViewCellIdentifier;

/**
 * Cell containing a text view with a placeholder. Compatible with auto-layout and tableView automatic row height.
 **/
@interface MJTextViewCell : UITableViewCell <UITextViewDelegate>

/** ************************************************************ **
 * @name Properties
 ** ************************************************************ **/

/**
 * The placeholder label.
 **/
@property (nonatomic, strong, readonly) UILabel *placeholderLabel;

/**
 * The text view.
 **/
@property (nonatomic, strong, readonly) UITextView *textView;

/** ************************************************************ **
 * @name Configuration
 ** ************************************************************ **/

/**
 * YES to resign first responder when textView receives return line key.
 **/
@property (nonatomic, assign) BOOL returnLineResignsTextView;

/** ************************************************************ **
 * @name Delegate
 ** ************************************************************ **/

/**
 * Cell's delegate.
 **/
@property (nonatomic, weak) id <MJTextViewCellDelegate> delegate;

/**
 * Text did change block.
 * @discussion Careful with not creating retain cycles when defining the block.
 **/
@property (nonatomic, strong) void (^textDidChange)(NSString *text);

/**
 * Forces a refresh of the view.
 **/
- (void)refreshView;

@end

/**
 * Delegate object protocol.
 **/
@protocol MJTextViewCellDelegate <NSObject>

/** ************************************************************ **
 * @name Methods
 ** ************************************************************ **/

@optional

/**
 * Method called when resigning the first responder of the keyboard.
 * @param cell The cell.
 * @param text The final text.
 **/
- (void)textViewCell:(MJTextViewCell*)cell didFinishEditingWithText:(NSString*)text;

/**
 * Method called on each text change.
 * @param cell The cell.
 * @param text The new text.
 **/
- (void)textViewCell:(MJTextViewCell *)cell didChangeText:(NSString*)text;

@end
