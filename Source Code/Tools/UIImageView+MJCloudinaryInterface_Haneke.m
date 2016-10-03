//
//  UIImageView+MJCloudinaryInterface_Haneke.m
//  MJiOSCore
//
//  Created by Joan Martin on 03/10/16.
//  Copyright © 2016 MobileJazz. All rights reserved.
//

#import "UIImageView+MJCloudinaryInterface_Haneke.h"

@implementation UIImageView (MJCloudinaryInterface_Haneke)

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
