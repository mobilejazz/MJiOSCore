//
// Copyright 2015 Mobile Jazz SL
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

#import "UIBarButtonItem+Additions.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (Additions)

+ (UIBarButtonItem*)add_flexibleSpaceItem;
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+ (UIBarButtonItem*)add_fixedSpaceItem;
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
}

+ (__kindof UIBarButtonItem *)add_barButtonWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *item = [[self alloc] initWithImage:image style:style target:self action:@selector(add_barButtonItemAction:)];
    objc_setAssociatedObject(item, @selector(add_barButtonItemAction:), block, OBJC_ASSOCIATION_COPY);
    return item;
}

+ (__kindof UIBarButtonItem *)add_barButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *item = [[self alloc] initWithTitle:title style:style target:self action:@selector(add_barButtonItemAction:)];
    objc_setAssociatedObject(item, @selector(add_barButtonItemAction:), block, OBJC_ASSOCIATION_COPY);
    return item;
}

+ (__kindof UIBarButtonItem *)add_barButtonWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void (^)(id sender))block
{
    UIBarButtonItem *item = [[self alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(add_barButtonItemAction:)];
        objc_setAssociatedObject(item, @selector(add_barButtonItemAction:), block, OBJC_ASSOCIATION_COPY);
    return item;
}

#pragma mark Private Methods

- (void)add_barButtonItemAction:(id)sender
{
    void (^block)(id sender) = objc_getAssociatedObject(self, @selector(add_barButtonItemAction:));
    
    if (block)
        block(sender);
}

@end
