#import "UIView+SeparatorSubview.h"

@implementation UIView (SeparatorSubview)

#pragma mark - Public

- (UIView *)add_separatorViewAtPosition:(MJSeparatorPosition)position
                              withColor:(UIColor *)color
                              thickness:(CGFloat)thickness
                                 margin:(CGFloat)margin
{
    UIView *separatorView = [UIView separatorViewWithColor:color];
    [self addSubview:separatorView];
    switch (position)
    {
        case MJSeparatorPositionLeading:
            [self layoutLeadingSeparatorView:separatorView width:thickness margin:margin];
            break;
        case MJSeparatorPositionTop:
            [self layoutTopSeparatorView:separatorView height:thickness margin:margin];
            break;
        case MJSeparatorPositionTrailing:
            [self layoutTrailingSeparatorView:separatorView width:thickness margin:margin];
            break;
        case MJSeparatorPositionBottom:
            [self layoutBottomSeparatorView:separatorView height:thickness margin:margin];
            break;
    }
    return separatorView;
}

#pragma mark - Private

/**
 Creates and configures a separator view
 */
+ (UIView *)separatorViewWithColor:(UIColor *)color
{
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectZero];
    separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    separatorView.backgroundColor = color;
    return separatorView;
}

#pragma mark Layout methods

- (void)layoutLeadingSeparatorView:(UIView *)separatorView width:(CGFloat)width margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0)
{
    NSArray<NSLayoutConstraint *> *constraints = @[
       [separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
       [separatorView.topAnchor constraintEqualToAnchor:self.topAnchor constant:margin],
       [separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-margin],
       [separatorView.widthAnchor constraintEqualToConstant:width]
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)layoutTopSeparatorView:(UIView *)separatorView height:(CGFloat)height margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0)
{
    NSArray<NSLayoutConstraint *> *constraints = @[
       [separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:margin],
       [separatorView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-margin],
       [separatorView.heightAnchor constraintEqualToConstant:height]
    ];
    [NSLayoutConstraint activateConstraints:constraints];
 }

- (void)layoutTrailingSeparatorView:(UIView *)separatorView width:(CGFloat)width margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0)
{
    NSArray<NSLayoutConstraint *> *constraints = @[
       [separatorView.topAnchor constraintEqualToAnchor:self.topAnchor constant:margin],
       [separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
       [separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-margin],
       [separatorView.widthAnchor constraintEqualToConstant:width]
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)layoutBottomSeparatorView:(UIView *)separatorView height:(CGFloat)height margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0)
{
    NSArray<NSLayoutConstraint *> *constraints = @[
       [separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:margin],
       [separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-margin],
       [separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [separatorView.heightAnchor constraintEqualToConstant:height]
    ];
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
