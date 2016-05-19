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

#import "UIImageView+Cloudinary_Haneke.h"

#import <objc/runtime.h>

CLCloudinaryCropMode CLCloudinaryCropModeFromUIViewContentMode(UIViewContentMode contentMode)
{
    CLCloudinaryCropMode cropMode = CLCloudinaryCropModeScaleAspectFit;
    
    switch (contentMode)
    {
        case UIViewContentModeScaleToFill:
            cropMode = CLCloudinaryCropModeScaleToFill;
            break;
        case UIViewContentModeScaleAspectFit:
            cropMode = CLCloudinaryCropModeScaleAspectFit;
            break;
        case UIViewContentModeScaleAspectFill:
            cropMode = CLCloudinaryCropModeScaleAspectFill;
            break;
        case UIViewContentModeCenter:
            cropMode = CLCloudinaryCropModeCenter;
            break;
        case UIViewContentModeTop:
            cropMode = CLCloudinaryCropModeTop;
            break;
        case UIViewContentModeBottom:
            cropMode = CLCloudinaryCropModeBottom;
            break;
        case UIViewContentModeLeft:
            cropMode = CLCloudinaryCropModeLeft;
            break;
        case UIViewContentModeRight:
            cropMode = CLCloudinaryCropModeRight;
            break;
        case UIViewContentModeTopLeft:
            cropMode = CLCloudinaryCropModeTopLeft;
            break;
        case UIViewContentModeTopRight:
            cropMode = CLCloudinaryCropModeTopRight;
            break;
        case UIViewContentModeBottomLeft:
            cropMode = CLCloudinaryCropModeBottomLeft;
            break;
        case UIViewContentModeBottomRight:
            cropMode = CLCloudinaryCropModeBottomRight;
            break;
            
        case UIViewContentModeRedraw:
            // Nothing to do
            break;
    }
    
    return cropMode;
}

@implementation UIImageView (Cloudinary_Haneke)

#pragma mark Properties

- (void)setCloudinary:(CLCloudinary *)cloudinary
{
    objc_setAssociatedObject(self, @selector(cloudinary), cloudinary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLCloudinary*)cloudinary
{
    return objc_getAssociatedObject(self, @selector(cloudinary));
}

- (CLCloudinaryCropMode)cloudinaryCropMode
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(cloudinaryCropMode));
    if (number)
        return [number unsignedIntegerValue];
    
    return CLCloudinaryCropModeFromUIViewContentMode(self.contentMode);
}

- (void)setCloudinaryCropMode:(CLCloudinaryCropMode)cloudinaryCropMode
{
    objc_setAssociatedObject(self, @selector(cloudinaryCropMode), @(cloudinaryCropMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Public Methods

- (void)setImageFromImageKey:(NSString*)imageKey
{
    [self setImageFromImageKey:imageKey placeholder:nil];
}

- (void)setImageFromImageKey:(NSString*)imageKey
                    placeholder:(UIImage*)placeholder
{
    CLCloudinary *cloudinary = self.cloudinary;
    if (!cloudinary)
        cloudinary = [CLCloudinary defaultCloudinary];
    
    NSURL *url = [cloudinary urlForImageWithId:imageKey
                                          size:self.bounds.size
                                      cropMode:self.cloudinaryCropMode];
    
    [self hnk_setImageFromURL:url placeholder:placeholder];
}


- (void)setImageFromImageKey:(NSString*)imageKey
                    placeholder:(UIImage*)placeholder
                        success:(void (^)(UIImage *image))successBlock
                        failure:(void (^)(NSError *error))failureBlock
{
    CLCloudinary *cloudinary = self.cloudinary;
    if (!cloudinary)
        cloudinary = [CLCloudinary defaultCloudinary];
    
    NSURL *url = [cloudinary urlForImageWithId:imageKey
                                          size:self.bounds.size
                                      cropMode:self.cloudinaryCropMode];
    
    [self hnk_setImageFromURL:url placeholder:placeholder success:successBlock failure:failureBlock];
}

- (void)setImageFromImageKey:(NSString*)imageKey
              transformation:(CLTransformation*)transformation
{
    [self setImageFromImageKey:imageKey placeholder:nil transformation:transformation];
}

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder
              transformation:(CLTransformation*)transformation
{
    CLCloudinary *cloudinary = self.cloudinary;
    if (!cloudinary)
        cloudinary = [CLCloudinary defaultCloudinary];
    
    NSURL *url = [cloudinary urlForImageWithId:imageKey
                                transformation:transformation];
    
    [self hnk_setImageFromURL:url placeholder:placeholder];
}

- (void)setImageFromImageKey:(NSString*)imageKey
                 placeholder:(UIImage*)placeholder
              transformation:(CLTransformation*)transformation
                     success:(void (^)(UIImage *image))successBlock
                     failure:(void (^)(NSError *error))failureBlock
{
    CLCloudinary *cloudinary = self.cloudinary;
    if (!cloudinary)
        cloudinary = [CLCloudinary defaultCloudinary];
    
    NSURL *url = [cloudinary urlForImageWithId:imageKey
                                transformation:transformation];
    
    [self hnk_setImageFromURL:url placeholder:placeholder success:successBlock failure:failureBlock];
}

@end
