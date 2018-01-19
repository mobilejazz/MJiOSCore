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

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

/**
 Sets the background color of an UIButton using an image of the desired color

 @param color color for the background
 @param state state to apply the new configuration
 */
- (void)add_setBackgrounColor:(UIColor*)color forState:(UIControlState)state;

/**
 Sets the background color of an UIButton using an image of the desired color with the specified radius.
 
 @param color color for the background
 @param radius corner radius size
 @param state state to apply the new configuration
 */
- (void)add_setBackgrounColor:(UIColor*)color cornerRadius:(CGFloat)radius forState:(UIControlState)state;

@end
