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

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

static NSString *kUIActionSheetCompletionBlockKey = @"kUIActionSheetCompletionBlockKey";

@implementation UIActionSheet (Blocks)

- (void)showInView:(UIView *)view completionBlock:(UIActionSheetCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = self;
    [self showInView:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated completionBlock:(UIActionSheetCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = self;
    [self showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated completionBlock:(UIActionSheetCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = self;
    [self showFromRect:rect inView:view animated:animated];
}

- (void)showFromTabBar:(UITabBar *)view completionBlock:(UIActionSheetCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = self;
    [self showFromTabBar:view];
}

- (void)showFromToolbar:(UIToolbar *)view completionBlock:(UIActionSheetCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.delegate = self;
    [self showFromToolbar:view];
}

#pragma mark UIActionSheetDelegate

/*
 * Sent to the delegate when the user clicks a button on an action sheet.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    UIActionSheetCompletionBlock completionBlock = objc_getAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey));
    
    if (completionBlock != nil)
        completionBlock(actionSheet, buttonIndex);
    
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetCompletionBlockKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma GCC diagnostic pop
