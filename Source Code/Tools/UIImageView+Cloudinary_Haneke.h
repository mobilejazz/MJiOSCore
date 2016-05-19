//
// Copyright 2016 Mobile Jazz SL
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

#import <Haneke/Haneke.h>
#import "CLCloudinary+Additions.h"

extern CLCloudinaryCropMode CLCloudinaryCropModeFromUIViewContentMode(UIViewContentMode contentMode);

@interface UIImageView (Cloudinary_Haneke)

@property (nonatomic, readwrite) CLCloudinary *cloudinary UI_APPEARANCE_SELECTOR;
@property (nonatomic, readwrite) CLCloudinaryCropMode cloudinaryCropMode UI_APPEARANCE_SELECTOR;

/** *************************************************** **
 * @name Setting images
 ** *************************************************** **/

- (void)setImageFromImageKey:(NSString*)imageKey;

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder;

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder
                     success:(void (^)(UIImage *image))successBlock
                     failure:(void (^)(NSError *error))failureBlock;

- (void)setImageFromImageKey:(NSString*)imageKey
              transformation:(CLTransformation*)transformation;

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder
              transformation:(CLTransformation*)transformation;

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder
              transformation:(CLTransformation*)transformation
                     success:(void (^)(UIImage *image))successBlock
                     failure:(void (^)(NSError *error))failureBlock;
@end
