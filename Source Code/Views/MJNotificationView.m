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

#import "MJNotificationView.h"

#define kMJNotificationViewMinimumHeight            64

#define kMJNotificationViewTopMargin                21
#define kMJNotificationViewBottomMargin             21
#define kMJNotificationViewLeftMargin               30
#define kMJNotificationViewRightMargin              30

#define kMJNotificationViewExteriorRightMargin      0
#define kMJNotificationViewExteriorLeftMargin       0

#define kMJNotifcationDisplayTime                   4 // seconds

static NSOperationQueue *_operationQueue = nil;
static NSString *_lastKey = nil;

@implementation MJNotificationView
{
    UILabel *_label;
    BOOL _closed;
    UITapGestureRecognizer *_tapGestureRecognizer;
    UISwipeGestureRecognizer *_swipeGestureRecognizer;
    void (^_theNextBlock)(void);
    
    MJNotificationViewUserInteraction _userInteraction;
    void (^_dismissBlock)(MJNotificationViewUserInteraction userInteraction, NSDictionary *userInfo);
}

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    });
}

- (id)initWithText:(NSString*)text
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 80)];
    if (self)
    {
        self.tintColor = [[UIColor cyanColor] colorWithAlphaComponent:0.8];
        
        _text = text;
        _userInteraction = MJNotificationViewUserInteractionNone;
        
        NSMutableParagraphStyle *textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentCenter;
        textStyle.firstLineHeadIndent = 16.0f;
        
        _textAttributes = @{NSFontAttributeName            : [UIFont systemFontOfSize:16],
                            NSForegroundColorAttributeName : [UIColor whiteColor],
                            NSParagraphStyleAttributeName  : textStyle,
                            };
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.attributedText = [[NSAttributedString alloc] initWithString:_text attributes:_textAttributes];
        
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_label];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_label
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_label.superview
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:kMJNotificationViewTopMargin];
        [self addConstraint:topConstraint];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_label
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_label.superview
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:kMJNotificationViewLeftMargin];
        [self addConstraint:leftConstraint];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_label
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_label.superview
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:-kMJNotificationViewRightMargin];
        [self addConstraint:rightConstraint];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_label
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_label.superview
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:-kMJNotificationViewBottomMargin];
        [self addConstraint:bottomConstraint];
    }
    return self;
}

#pragma mark Properties

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    self.backgroundColor = tintColor;
}

#pragma mark Autolayout

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
{
    CGSize finalSize = targetSize;
    finalSize.width -= kMJNotificationViewExteriorLeftMargin + kMJNotificationViewExteriorRightMargin;
    finalSize.height = [self mjz_heightForTargetSize:targetSize];
    return finalSize;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
        withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority
              verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    CGSize finalSize = targetSize;
    finalSize.width -= kMJNotificationViewExteriorLeftMargin + kMJNotificationViewExteriorRightMargin;
    finalSize.height = [self mjz_heightForTargetSize:targetSize];
    return finalSize;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize finalSize = [self systemLayoutSizeFittingSize:size];
    return finalSize;
}

#pragma mark Public Methods

- (void)show
{
    return [self showWithDismissBlock:nil];
}

- (void)showWithDismissBlock:(void(^)(MJNotificationViewUserInteraction userInteraction, NSDictionary *userInfo))dismissBlock
{
    _closed = NO;
    _dismissBlock = dismissBlock;
    
    NSString *key = _text;
    
    [self.class mjz_enqueueWithKey:key block:^(void (^nextBlock)()) {
        
        // Retrieving the displaying view
        UIView *displayView = [UIApplication sharedApplication].keyWindow;
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mjz_tapped:)];
        _swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(mjz_swipped:)];
        _swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        
        [self addGestureRecognizer:_tapGestureRecognizer];
        [self addGestureRecognizer:_swipeGestureRecognizer];
        //[displayView addGestureRecognizer:_tapGestureRecognizer];
        //[displayView addGestureRecognizer:_swipeGestureRecognizer];
        
        // Setting a default frame to the current notification view.
        self.frame = displayView.bounds;
        
        // Resizing the current notification view
        [self sizeToFit];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        // Displaying the notification view
        [self mjz_displayOnView:displayView completionBlock:^{
            _theNextBlock = nextBlock;
            
            // Waiting before hiding it.
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMJNotifcationDisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self mjz_endShow];
            });
        }];
    }];
}

+ (void)clearShowQueue
{
    [_operationQueue cancelAllOperations];
}

#pragma mark Private Methods

- (void)mjz_endShow
{
    if (_closed)
        return;
    
    _closed = YES;
    
    [self removeGestureRecognizer:_tapGestureRecognizer];
    [self removeGestureRecognizer:_swipeGestureRecognizer];
    
    if (_dismissBlock)
        _dismissBlock(_userInteraction, _userInfo);
    
    _dismissBlock = nil;
    
    if (_theNextBlock)
        _theNextBlock();
    
    // Hiding the current notification view
    [self mjz_hideWithCompletionBlock:nil];
}

- (void)mjz_tapped:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        _userInteraction = MJNotificationViewUserInteractionTap;
        [self mjz_endShow];
    }
}

- (void)mjz_swipped:(UISwipeGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        _userInteraction = MJNotificationViewUserInteractionDismiss;
        [self mjz_endShow];
    }
}

- (void)mjz_displayOnView:(UIView*)view completionBlock:(void(^)())completionBlock
{
    CGRect bounds = self.bounds;
    
    CGRect initialFrame = CGRectMake(kMJNotificationViewExteriorLeftMargin,
                                     -bounds.size.height,
                                     bounds.size.width,
                                     bounds.size.height);
    
    CGRect finalFrame = CGRectMake(kMJNotificationViewExteriorLeftMargin,
                                   0,
                                   bounds.size.width,
                                   bounds.size.height);
    
    self.frame = initialFrame;
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        if (completionBlock)
            completionBlock();
    }];
}

- (void)mjz_hideWithCompletionBlock:(void(^)())completionBlock
{
    CGRect bounds = self.bounds;
    
    CGRect finalFrame = CGRectMake(kMJNotificationViewExteriorLeftMargin,
                                   -bounds.size.height,
                                   bounds.size.width,
                                   bounds.size.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (completionBlock)
            completionBlock();
    }];
}

+ (void)mjz_enqueueBlock:(void (^)(void (^nextBlock)()))block
{
    [self mjz_enqueueWithKey:nil block:block];
}

+ (void)mjz_enqueueWithKey:(NSString*)key block:(void (^)(void (^nextBlock)()))block
{
    if (_lastKey && [_lastKey isEqualToString:key])
    {
        // Do not execute two blocks in a row with the same key.
        return;
    }
    
    // The operation queue only supports one active operation at once
    [_operationQueue addOperationWithBlock:^{
        _lastKey = key;
        
        // Creating a semaphore
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        // Moving to main thread to perform the block
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Performing the block.
            block(^{
                // The "nextBlock" will signal the semaphore and finish the operation
                dispatch_semaphore_signal(semaphore);
            });
        });
        
        // Wait until the semaphore is signaled
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        _lastKey = nil;
    }];
}

- (CGFloat)mjz_heightForTargetSize:(CGSize)targetSize
{
    // Computing the size of the label from a target size
    
    CGFloat width = targetSize.width;
    CGSize size = CGSizeMake(width - kMJNotificationViewLeftMargin - kMJNotificationViewRightMargin, CGFLOAT_MAX);
    
    CGRect bounds = [_text boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:_textAttributes
                                        context:nil];
    
    return MAX(kMJNotificationViewMinimumHeight, ceilf(bounds.size.height + kMJNotificationViewTopMargin + kMJNotificationViewBottomMargin));
}

@end
