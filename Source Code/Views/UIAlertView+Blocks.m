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

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

static NSString *kUIAlertViewCompletionBlockKey = @"kUIAlertViewCompletionBlockKey";

@implementation UIAlertView (Blocks)

- (void)showWithCompletionBlock:(UIAlertViewCompletionBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kUIAlertViewCompletionBlockKey), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
    [self show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertViewCompletionBlock completionBlock = objc_getAssociatedObject(self, (__bridge const void *)(kUIAlertViewCompletionBlockKey));
    
    if (completionBlock != nil)
        completionBlock(alertView, buttonIndex);
    
    objc_setAssociatedObject(self, (__bridge const void *)(kUIAlertViewCompletionBlockKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma GCC diagnostic pop
