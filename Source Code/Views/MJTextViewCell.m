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

#import "MJTextViewCell.h"

#import "UIView+Additions.h"

#define MINIMUM_HEIGHT 40.0f
#define PLACEHOLDER_MARGIN 0.0f

static CGFloat const kUITextViewHorizontalPadding = 10;

NSString * const MJTextViewCellIdentifier = @"MJTextViewCellIdentifier";

@implementation MJTextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self mjz_doInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self mjz_doInit];
}

- (void)mjz_doInit
{
    _returnLineResignsTextView = YES;
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.hidden = YES;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView.textColor = [UIColor blackColor];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.scrollEnabled = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:_placeholderLabel];
    [self.contentView addSubview:_textView];
    
    [_textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [_textView removeObserver:self forKeyPath:@"text" context:nil];
}

- (void)setReturnLineResignsTextView:(BOOL)returnLineResignsTextView
{
    _returnLineResignsTextView = returnLineResignsTextView;
    
    if (returnLineResignsTextView)
        _textView.returnKeyType = UIReturnKeyDone;
    else
        _textView.returnKeyType = UIReturnKeyDefault;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGRect textViewFrame = bounds;
    textViewFrame.origin.x = self.separatorInset.left - kUITextViewHorizontalPadding/2.0;
    textViewFrame.size.width = bounds.size.width - self.separatorInset.left - self.separatorInset.right;
    _textView.frame = textViewFrame;

    CGRect labelFrame = textViewFrame;
    labelFrame.size.width -= self.textView.textContainerInset.left + self.textView.textContainerInset.right;
    _placeholderLabel.frame = labelFrame;
    [_placeholderLabel sizeToFit];
    
    labelFrame = _placeholderLabel.bounds;
    labelFrame.origin.x = self.separatorInset.left + self.textView.textContainerInset.left;
    labelFrame.origin.y = self.textView.textContainerInset.top;
    _placeholderLabel.frame = labelFrame;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _textView.text = nil;
    _placeholderLabel.text = nil;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
{
    CGSize finalSize = targetSize;
    finalSize.height = [self mjz_heightForTargetSize:targetSize];
    return finalSize;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
        withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority
              verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    CGSize finalSize = targetSize;
    finalSize.height = [self mjz_heightForTargetSize:targetSize];
    return finalSize;
}

- (void)refreshView
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    BOOL hidden = _textView.text.length != 0;
    _placeholderLabel.hidden = hidden;
}

#pragma mark Private Methods

- (CGFloat)mjz_heightForTargetSize:(CGSize)size
{
    NSString *text = _textView.text;
    UIFont *font = _textView.font;
    
    if (!text || text.length == 0)
    {
        text = _placeholderLabel.text;
        font = _placeholderLabel.font;
    }
    
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(size.width - self.separatorInset.left - self.separatorInset.right - kUITextViewHorizontalPadding, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: font}
                                                 context:nil];
    
    return ceilf(MAX([self mjz_minimumHeightForSize:size], bounds.size.height + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom + 1));
}

- (CGFloat)mjz_minimumHeightForSize:(CGSize)size
{
    NSString *text = _placeholderLabel.text;
    UIFont *font = _placeholderLabel.font;
 
    if (text.length == 0)
        return MINIMUM_HEIGHT;
    
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(size.width - self.separatorInset.left - self.separatorInset.right - kUITextViewHorizontalPadding, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    
    return ceilf(MAX(MINIMUM_HEIGHT, bounds.size.height + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom + 1));
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshView];
}

#pragma mark - Protocols
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_returnLineResignsTextView)
    {
        if ([text isEqualToString:@"\n"])
        {
            UIView *nextResponder = [textView add_nextFirstResponder];
            if (nextResponder)
                [nextResponder becomeFirstResponder];
            else
                [textView resignFirstResponder];
            
            return NO;
        }
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *text = textView.text;
    
    _placeholderLabel.hidden = text.length != 0;
    
    if ([_delegate respondsToSelector:@selector(textViewCell:didChangeText:)])
        [_delegate textViewCell:self didChangeText:text];
    
    if (_textDidChange)
        _textDidChange(text);
    
    
    CGSize size = textView.bounds.size;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(size.width, CGFLOAT_MAX)];
    
    if (size.height != newSize.height)
    {
        static UITableView* (^seekTableView)(UIView *view) = ^UITableView*(UIView *view) {
            while (view != nil)
            {
                if ([view isKindOfClass:UITableView.class])
                {
                    UITableView *tableView = (id)view;
                    return tableView;
                }
                view = view.superview;
            }
            return nil;
        };
        
        UITableView *tableView = seekTableView(textView);
        [UIView setAnimationsEnabled:NO];
        [tableView beginUpdates];
        [tableView endUpdates];
        [UIView setAnimationsEnabled:YES];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(textViewCell:didFinishEditingWithText:)])
        [_delegate textViewCell:self didFinishEditingWithText:textView.text];
}

@end
