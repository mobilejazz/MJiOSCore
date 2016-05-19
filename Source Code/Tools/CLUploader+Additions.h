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

#import <Cloudinary/Cloudinary.h>
#import <UIKit/UIKit.h>

typedef void (^CLUploaderProgressBlock)(CGFloat progress);
typedef void (^CLUploaderCompletionBlock)(NSDictionary *result, NSString *cloudinaryId, NSString *error);

typedef NS_ENUM(NSUInteger, CLUploaderFormat)
{
    CLUploaderFormatJPG,
    CLUploaderFormatPNG,
};

@interface CLUploader (Additions)

- (BOOL)uploadImage:(UIImage*)image
             format:(CLUploaderFormat)format
    compressionRate:(CGFloat)compressionRate;

- (BOOL)uploadImage:(UIImage*)image
             format:(CLUploaderFormat)format
    compressionRate:(CGFloat)compressionRate
           progress:(CLUploaderProgressBlock)progressBlock
         completion:(CLUploaderCompletionBlock)completionBlock;

@end
