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
#import "UIResponder+Additions.h"

static __weak __kindof UIResponder *__currentFirstResponder = nil;

@implementation UIResponder (Additions)

+ (__kindof UIResponder*)add_firstResponder
{
    __currentFirstResponder = nil;
    
    // Apple Documentation: "If target is nil, the app sends the message to the first responder"
    [[UIApplication sharedApplication] sendAction:@selector(add_findFirstResponder:) to:nil from:nil forEvent:nil];
    
    return __currentFirstResponder;
}

- (void)add_findFirstResponder:(id)sender
{
    __currentFirstResponder = self;
}

@end