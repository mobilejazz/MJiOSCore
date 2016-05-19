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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MJCloudinaryImageCropMode)
{
    MJCloudinaryImageCropModeScaleToFill       = UIViewContentModeScaleToFill,
    MJCloudinaryImageCropModeScaleAspectFit    = UIViewContentModeScaleAspectFit,
    MJCloudinaryImageCropModeScaleAspectFill   = UIViewContentModeScaleAspectFill,
    MJCloudinaryImageCropModeCenter            = UIViewContentModeCenter,
    MJCloudinaryImageCropModeTop               = UIViewContentModeTop,
    MJCloudinaryImageCropModeBottom            = UIViewContentModeBottom,
    MJCloudinaryImageCropModeLeft              = UIViewContentModeLeft,
    MJCloudinaryImageCropModeRight             = UIViewContentModeRight,
    MJCloudinaryImageCropModeTopLeft           = UIViewContentModeTopLeft,
    MJCloudinaryImageCropModeTopRight          = UIViewContentModeTopRight,
    MJCloudinaryImageCropModeBottomLeft        = UIViewContentModeBottomLeft,
    MJCloudinaryImageCropModeBottomRight       = UIViewContentModeBottomRight,
    MJCloudinaryImageCropModeFace              = 1000000,
    MJCloudinaryImageCropModeFaces             = 1000001,
};

typedef NSString MJCloudinaryImageFileFormat;

extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPNG;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatJPG;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatGIF;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatBMP;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatTIFF;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatICO;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPDF;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatEPS;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPSD;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatSVG;
extern MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatWEBP;

/**
 * Use this value as a corner radius parameter to indicate that the output image must have the bigger radius possible (squared images would becom round).
 **/
extern CGFloat const MJImageRadiusMax;

/**
 * Return the equivalent crop mode form a content mode value.
 **/
FOUNDATION_EXTERN MJCloudinaryImageCropMode MJCloudinaryImageCropModeFromUIViewContentMode(UIViewContentMode contentMode);

/**
 * Generates URLS for the image keys.
 **/
@interface MJCloudinaryInterface : NSObject

/** *************************************************** **
 * @name Accessing the default instance
 ** *************************************************** **/

/**
 * The default instance.
 * @return The shared instance.
 * @discussion The default instance is used in UIImageViews to acces the a cloudinary interface instance to generate the URLs. This instance must be configured.
 **/
+ (MJCloudinaryInterface*)defaultInterface;

/** *************************************************** **
 * @name Configuring the image composer
 ** *************************************************** **/

/**
 * The Cloudinary cloud name.
 **/
@property (nonatomic, readwrite) NSString *cloudName;

/**
 * The Cloudinary API key.
 **/
@property (nonatomic, readwrite) NSString *apiKey;

/**
 * The Cloudinary API secret.
 **/
@property (nonatomic, readwrite) NSString *apiSecret;

/**
 * The file format of the image to fetch. Default value is `MJCloudinaryImageFileFormatJPG`.
 **/
@property (nonatomic, strong) MJCloudinaryImageFileFormat *fileFormat;

/**
 * The file format of the image to fetch when a corner radius is defined. Default value is `MJCloudinaryImageFileFormatPNG`.
 **/
@property (nonatomic, strong) MJCloudinaryImageFileFormat *radiusFileFormat;

/**
 * The JPG compression quality. Value from 0 to 1 (0 the worst quality, 1 no quality compression). Default value is 1.
 **/
@property(nonatomic, assign) CGFloat jpgCompressionQuality;

/** *************************************************** **
 * @name Uploading images
 ** *************************************************** **/

/**
 * Upload an image to cloudinary.
 * @param file The file to upload
 * @param options A dictionary of options.
 * @param NO if the image couldn't be queued to upload, otherwise YES.
 **/
- (BOOL)uploadImage:(id)image options:(NSDictionary*)options;

/**
 * Upload an image to cloudinary.
 * @param file The file to upload
 * @param options A dictionary of options.
 * @param progressBlock The progress block.
 * @param completionBlock The completionBlock
 * @param NO if the image couldn't be queued to upload, otherwise YES.
 **/
- (BOOL)uploadImage:(id)image options:(NSDictionary*)options
           progress:(void (^)(CGFloat progress))progressBlock
         completion:(void (^)(NSDictionary *result, NSString *cloudinaryId, NSString *error))completionBlock;

/** *************************************************** **
 * @name Generating URLs
 ** *************************************************** **/

/**
 * Returns the original image.
 * @param imageKey The image key.
 * @return The URL of the image location.
 **/
- (NSURL*)URLForImageKey:(NSString *)imageKey;

/**
 * Returns the default image.
 * @param imageKey The image key.
 * @param size The desired size
 * @param cropMode The crop mode for the resizing.
 * @return The URL of the image location.
 * @discussion The scale of the image is set to the default screen resolution.
 **/
- (NSURL*)URLForImageKey:(NSString*)imageKey
                    size:(CGSize)size
                cropMode:(MJCloudinaryImageCropMode)cropMode
                  radius:(CGFloat)radius;

/**
 * Returns the default image.
 * @param imageKey The image key.
 * @param size The desired size
 * @param scale The scale of the image.
 * @param cropMode The crop mode for the resizing.
 * @return The URL of the image location.
 **/
- (NSURL*)URLForImageKey:(NSString*)imageKey
                    size:(CGSize)size
                   scale:(CGFloat)scale
                cropMode:(MJCloudinaryImageCropMode)cropMode radius:(CGFloat)radius;

/**
 * Returns the default image.
 * @param imageKey The image key.
 * @param pretransformCropRect A crop applied to the original image. The rect must be in the original image coordinates.
 * @param size The desired size
 * @param scale The scale of the image.
 * @param cropMode The crop mode for the resizing.
 * @return The URL of the image location.
 * @discussion This method applies first a crop to the original image and then applies a regular transfrom to the output image. If the pretransform crop is zero, then no croping is done.
 **/
- (NSURL*)URLForImageKey:(NSString*)imageKey
        pretransformCrop:(CGRect)pretransformCropRect
                    size:(CGSize)size scale:(CGFloat)scale
                cropMode:(MJCloudinaryImageCropMode)cropMode
                  radius:(CGFloat)radius;

/** *************************************************** **
 * @name Debug
 ** *************************************************** **/

/**
 * Enable debug logs. Default value is NO.
 **/
@property (nonatomic, assign) BOOL enableDebugLogs;

@end
