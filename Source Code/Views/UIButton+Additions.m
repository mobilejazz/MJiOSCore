//
// Copyright 2017 Mobile Jazz SL
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


#import "UIButton+Additions.h"
#import <UIImage+Additions/UIImage+Additions.h>

@implementation UIButton (Additions)

- (void)add_setBackgrounColor:(UIColor*)color forState:(UIControlState)state
{
    [self add_setBackgrounColor:color cornerRadius:0 forState:state];
}

- (void)add_setBackgrounColor:(UIColor*)color cornerRadius:(CGFloat)radius forState:(UIControlState)state
{
    UIImage *backgroundImage = [UIImage add_resizableImageWithColor:color cornerRadius:radius];
    [self setBackgroundImage:backgroundImage forState:state];
}

@end
