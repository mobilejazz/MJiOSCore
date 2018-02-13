#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NTSeparatorPosition) {
    NTSeparatorPositionLeading,
    NTSeparatorPositionTop,
    NTSeparatorPositionTrailing,
    NTSeparatorPositionBottom,
};

@interface UIView (SeparatorSubview)
/**
 Creates a separator view, adds it as a subview and
 returns it.
 
 @warning Separator view is setup using auto layout.
 
 @param position Position where to place the separator within the view: leading, top, trailing, bottom, etc.
 Check available ones in NTSeparatorPosition.
 @param color Separator color
 @param thickness Separator line thickness
 @param margin A value to be applied as margin to both sides of the separator. If it's an horizontal separator
 (top or bottom positions) will add `margin` distance to leading and trailing anchors.
 If it's a vertical separator will add top and bottom margins.
 @return The separator view, already added to the view hierarchy.
 */
- (UIView *)add_separatorViewAtPosition:(NTSeparatorPosition)position
                              withColor:(UIColor *)color
                              thickness:(CGFloat)thickness
                                 margin:(CGFloat)margin NS_AVAILABLE_IOS(9_0);
@end
