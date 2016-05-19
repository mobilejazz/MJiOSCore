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

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIView*)add_nextFirstResponder
{
    UIView *view = self;
    
    UITableViewCell *cell = nil;
    UITableView *tableView = nil;
    while (view != nil)
    {
        if ([view isKindOfClass:UITableViewCell.class])
            cell = (id)view;
        
        if ([view isKindOfClass:UITableView.class])
            tableView = (id)view;
        
        if (tableView && cell)
            break;
        
        view = view.superview;
    }
    
    if (cell && tableView)
    {
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        
        while (nextIndexPath.row < [tableView numberOfRowsInSection:indexPath.section])
        {
            UITableViewCell *nextCell = [tableView cellForRowAtIndexPath:nextIndexPath];
            
            NSMutableArray *subviews = [NSMutableArray array];
            if (nextCell)
            {
                [subviews addObject:nextCell];
            }
            
            while (subviews.count > 0)
            {
                UIView *view = [subviews firstObject];
                [subviews removeObjectAtIndex:0];
                [subviews addObjectsFromArray:view.subviews];
                
                if ([view isKindOfClass:UITextField.class] ||
                    [view isKindOfClass:UITextView.class])
                {
                    if (view.userInteractionEnabled &&
                        [view respondsToSelector:@selector(isEnabled)] &&
                        [(id)view isEnabled])
                    {
                        return view;
                    }
                }
            }
            
            nextIndexPath = [NSIndexPath indexPathForRow:nextIndexPath.row+1 inSection:indexPath.section];
        }
    }
    
    return nil;
}

- (id)add_subviewWithAccessibilityIdentifier:(NSString*)identifier
{
    return [self add_subviewPassingTest:^BOOL(__kindof UIView *view) {
        return [view.accessibilityIdentifier isEqualToString:identifier];
    }];
}

- (nonnull NSArray<__kindof UIView*>*)add_subviewsWithAccessibilityIdentifier:(nonnull NSString*)identifier
{
    return [self add_subviewsPassingTest:^BOOL(__kindof UIView *view) {
        return [view.accessibilityIdentifier isEqualToString:identifier];
    }];
}

- (void)add_enumerateSubviewsWithAccessibilityIdentifier:(nonnull NSString*)identifier
                                                 objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block
{
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return [view.accessibilityIdentifier isEqualToString:identifier];
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        block(view, stop);
    }];
}

- (id)add_subviewWithTag:(NSInteger)tag
{
    return [self add_subviewPassingTest:^BOOL(__kindof UIView *view) {
        return view.tag == tag;
    }];
}

- (nonnull NSArray<__kindof UIView*>*)add_subviewsWithTag:(NSInteger)tag
{
    return [self add_subviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return view.tag == tag;
    }];
}

- (void)add_enumerateSubviewsWithTag:(NSInteger)tag
                             objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block
{
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return view.tag == tag;
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        block(view, stop);
    }];
}

- (id)add_subviewOfClass:(Class)clazz
{
    return [self add_subviewPassingTest:^BOOL(__kindof UIView *view) {
        return [view isKindOfClass:clazz];
    }];
}

- (nonnull NSArray<__kindof UIView*>*)add_subviewsOfClass:(nonnull Class)clazz
{
    return [self add_subviewsPassingTest:^BOOL(__kindof UIView *view) {
        return [view isKindOfClass:clazz];
    }];
}

- (void)add_enumerateSubviewsOfClass:(nonnull Class)clazz
                             objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block
{
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return [view isKindOfClass:clazz];
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        block(view, stop);
    }];
}

- (nonnull NSArray<__kindof UIView*>*)add_allSubviews
{
    return [self add_subviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return YES;
    }];
}

- (void)add_enumerateAllSubviews:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block
{
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return YES;
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        block(view, stop);
    }];
}

- (id)add_subviewPassingTest:(BOOL (^_Nonnull)(__kindof UIView *view))testBlock
{
    __block UIView *subview = nil;
    
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return testBlock(view);
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        subview = view;
        *stop = YES;
    }];
    
    return subview;
}

- (NSArray*)add_subviewsPassingTest:(BOOL (^_Nonnull)(__kindof UIView *view))testBlock
{
    NSMutableArray *subviews = [NSMutableArray array];
    
    [self add_enumerateSubviewsPassingTest:^BOOL(__kindof UIView * _Nonnull view) {
        return testBlock(view);
    } objects:^(__kindof UIView * _Nonnull view, BOOL * _Nullable stop) {
        [subviews addObject:view];
    }];
    
    return [subviews copy];
}

- (void)add_enumerateSubviewsPassingTest:(BOOL (^_Nonnull)(__kindof UIView * _Nonnull view))testBlock
                                 objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self];
    
    while (array.count > 0)
    {
        UIView *view = [array firstObject];
        [array removeObjectAtIndex:0];
        
        if (view != self && testBlock(view))
        {
            BOOL stop = NO;
            block(view, &stop);
            if (stop)
                return;
        }
        
        [array addObjectsFromArray:view.subviews];
    }
}

- (void)add_setAnchorPoint:(CGPoint)anchorPoint
{
    CGPoint newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = anchorPoint;
}

- (UIImage *)add_imageByRenderingView
{
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0)
        return nil;
    
    CGFloat alpha = self.alpha;
    self.alpha = 1;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.alpha = alpha;
    
    return resultingImage;
}

@end
