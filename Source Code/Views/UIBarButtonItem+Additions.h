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

#import <UIKit/UIKit.h>

/**
 * Additions on UIBarButtonItem.
 **/
@interface UIBarButtonItem (Additions)

/**
 * Flexible space item.
 **/
+ (UIBarButtonItem*)add_flexibleSpaceItem;

/**
 * Fixed space item.
 **/
+ (UIBarButtonItem*)add_fixedSpaceItem;

/**
 * Initializes a new item using the specified image and other properties.
 * @param image The image
 * @param style The style
 * @param block The action block.
 * @return An initialized instance.
 **/
+ (__kindof UIBarButtonItem *)add_barButtonWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id sender))block;

/**
 * Initializes a new item using the specified title and other properties.
 * @param title The title
 * @param style The style
 * @param block The action block.
 * @return An initialized instance.
 **/
+ (__kindof UIBarButtonItem *)add_barButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id sender))block;

/**
 * Initializes a new item containing the specified system item.
 * @param systemItem The sytem item value.
 * @param style The style
 * @param block The action block.
 * @return An initialized instance.
 **/
+ (__kindof UIBarButtonItem *)add_barButtonWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void (^)(id sender))block;

@end
