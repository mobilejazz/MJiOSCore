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

#import "UIImageView+MJCloudinaryInterface.h"
#import <objc/runtime.h>
#import <Haneke/Haneke.h>

#pragma mark - UIImageView Extension

MJCloudinaryImageCropMode MJCloudinaryImageCropModeFromUIViewContentMode(UIViewContentMode contentMode)
{
    MJCloudinaryImageCropMode cropMode = MJCloudinaryImageCropModeScaleAspectFit;
    
    switch (contentMode)
    {
        case UIViewContentModeScaleToFill:
            cropMode = MJCloudinaryImageCropModeScaleToFill;
            break;
        case UIViewContentModeScaleAspectFit:
            cropMode = MJCloudinaryImageCropModeScaleAspectFit;
            break;
        case UIViewContentModeScaleAspectFill:
            cropMode = MJCloudinaryImageCropModeScaleAspectFill;
            break;
        case UIViewContentModeCenter:
            cropMode = MJCloudinaryImageCropModeCenter;
            break;
        case UIViewContentModeTop:
            cropMode = MJCloudinaryImageCropModeTop;
            break;
        case UIViewContentModeBottom:
            cropMode = MJCloudinaryImageCropModeBottom;
            break;
        case UIViewContentModeLeft:
            cropMode = MJCloudinaryImageCropModeLeft;
            break;
        case UIViewContentModeRight:
            cropMode = MJCloudinaryImageCropModeRight;
            break;
        case UIViewContentModeTopLeft:
            cropMode = MJCloudinaryImageCropModeTopLeft;
            break;
        case UIViewContentModeTopRight:
            cropMode = MJCloudinaryImageCropModeTopRight;
            break;
        case UIViewContentModeBottomLeft:
            cropMode = MJCloudinaryImageCropModeBottomLeft;
            break;
        case UIViewContentModeBottomRight:
            cropMode = MJCloudinaryImageCropModeBottomRight;
            break;
            
        case UIViewContentModeRedraw:
            // Nothing to do
            break;
    }
    
    return cropMode;
}

@implementation UIImageView (MJCloudinaryInterface)

#pragma mark Properties

- (void)mjz_setCloudinaryInterface:(MJCloudinaryInterface *)urlImageComposer
{
    objc_setAssociatedObject(self, @selector(mjz_cloudinaryInterface), urlImageComposer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MJCloudinaryInterface*)mjz_cloudinaryInterface
{
    return objc_getAssociatedObject(self, @selector(mjz_cloudinaryInterface));
}

- (MJCloudinaryImageCropMode)mjz_imageCropMode
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(mjz_imageCropMode));
    if (number)
        return [number unsignedIntegerValue];
    
    return MJCloudinaryImageCropModeFromUIViewContentMode(self.contentMode);
}

- (void)mjz_setImageCropMode:(MJCloudinaryImageCropMode)mjz_imageCropMode
{
    objc_setAssociatedObject(self, @selector(mjz_imageCropMode), @(mjz_imageCropMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Public Methods

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
{
    [self mjz_setImageFromImageKey:imageKey radius:0 placeholder:nil];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey radius:(CGFloat)radius
{
    [self mjz_setImageFromImageKey:imageKey radius:radius placeholder:nil];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey placeholder:(UIImage*)placeholder
{
    [self mjz_setImageFromImageKey:imageKey radius:0 placeholder:placeholder];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
{
    MJCloudinaryInterface *cloudinaryInterface = self.mjz_cloudinaryInterface;
    
    if (!cloudinaryInterface)
        cloudinaryInterface = [MJCloudinaryInterface defaultInterface];
    
    NSURL *url = [cloudinaryInterface URLForImageKey:imageKey
                                                size:self.bounds.size
                                            cropMode:self.mjz_imageCropMode
                                              radius:radius];
    
    [self hnk_setImageFromURL:url placeholder:placeholder];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                pretransformCrop:(CGRect)pretransformCrop
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
{
    MJCloudinaryInterface *cloudinaryInterface = self.mjz_cloudinaryInterface;
    
    if (!cloudinaryInterface)
        cloudinaryInterface = [MJCloudinaryInterface defaultInterface];
    
    NSURL *url = [cloudinaryInterface URLForImageKey:imageKey
                                    pretransformCrop:pretransformCrop
                                                size:self.bounds.size
                                               scale:[UIScreen mainScreen].scale
                                            cropMode:self.mjz_imageCropMode
                                              radius:radius];
    
    [self hnk_setImageFromURL:url placeholder:placeholder];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock
{
    [self mjz_setImageFromImageKey:imageKey radius:0 placeholder:placeholder success:successBlock failure:failureBlock];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock
{
    MJCloudinaryInterface *cloudinaryInterface = self.mjz_cloudinaryInterface;
    
    if (!cloudinaryInterface)
        cloudinaryInterface = [MJCloudinaryInterface defaultInterface];
    
    NSURL *url = [cloudinaryInterface URLForImageKey:imageKey
                                                size:self.bounds.size
                                            cropMode:self.mjz_imageCropMode
                                              radius:radius];
    
    [self hnk_setImageFromURL:url placeholder:placeholder success:successBlock failure:failureBlock];
}

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                pretransformCrop:(CGRect)pretransformCrop
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock
{
    MJCloudinaryInterface *cloudinaryInterface = self.mjz_cloudinaryInterface;
    
    if (!cloudinaryInterface)
        cloudinaryInterface = [MJCloudinaryInterface defaultInterface];
    
    NSURL *url = [cloudinaryInterface URLForImageKey:imageKey
                                    pretransformCrop:pretransformCrop
                                                size:self.bounds.size
                                               scale:[UIScreen mainScreen].scale
                                            cropMode:self.mjz_imageCropMode
                                              radius:radius];
    
    [self hnk_setImageFromURL:url placeholder:placeholder success:successBlock failure:failureBlock];
}

@end
