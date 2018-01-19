//
//  UIImageView+MJCloudinaryInterface_Haneke.h
//  MJiOSCore
//
//  Created by Joan Martin on 03/10/16.
//  Copyright © 2016 MobileJazz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Haneke/Haneke.h>
#import "UIImageView+MJCloudinaryInterface.h"

@interface UIImageView (MJCloudinaryInterface_Haneke)

/** *************************************************** **
 * @name Setting images using Haneke
 ** *************************************************** **/

- (void)mjz_setImageFromImageKey:(NSString*)imageKey;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey radius:(CGFloat)radius;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey placeholder:(UIImage*)placeholder;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                pretransformCrop:(CGRect)pretransformCrop
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock;

- (void)mjz_setImageFromImageKey:(NSString*)imageKey
                pretransformCrop:(CGRect)pretransformCrop
                          radius:(CGFloat)radius
                     placeholder:(UIImage*)placeholder
                         success:(void (^)(UIImage *image))successBlock
                         failure:(void (^)(NSError *error))failureBlock;

@end
