#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MJSeparatorPosition) {
    MJSeparatorPositionLeading,
    MJSeparatorPositionTop,
    MJSeparatorPositionTrailing,
    MJSeparatorPositionBottom,
};

@interface UIView (SeparatorSubview)
/**
 Creates a separator view, adds it as a subview and
 returns it.
 The view adding the separator can hold a (weak) referece to it if it needs
 to manipulate the view at a later point. For ex. a cell may need to show/hide the separator in `cellForRow`. 
 
 @warning Separator view is setup using auto layout.
 
 @param position Position where to place the separator within the view: leading, top, trailing, bottom, etc.
 Check available ones in MJSeparatorPosition.
 @param color Separator color
 @param thickness Separator line thickness
 @param margin A value to be applied as margin to both sides of the separator. If it's an horizontal separator
 (top or bottom positions) will add `margin` distance to leading and trailing anchors.
 If it's a vertical separator will add top and bottom margins.
 @return The separator view, already added to the view hierarchy.
 */
- (UIView *)add_separatorViewAtPosition:(MJSeparatorPosition)position
                              withColor:(UIColor *)color
                              thickness:(CGFloat)thickness
                                 margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0);
@end
