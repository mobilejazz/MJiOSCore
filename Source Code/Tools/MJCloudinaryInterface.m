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

#import "MJCloudinaryInterface.h"

#import <Cloudinary/Cloudinary.h>

// Cloudinary Image Transformations: http://cloudinary.com/documentation/image_transformations

CGFloat const MJImageRadiusMax = CGFLOAT_MAX;

MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPNG = @"png";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatJPG = @"jpg";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatGIF = @"gif";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatBMP = @"bmp";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatTIFF = @"tiff";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatICO = @"ico";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPDF = @"pdf";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatEPS = @"eps";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatPSD = @"psd";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatSVG = @"svg";
MJCloudinaryImageFileFormat * const MJCloudinaryImageFileFormatWEBP = @"webp";

@implementation MJCloudinaryInterface
{
    CLCloudinary *_cloudinary;
}

+ (MJCloudinaryInterface*)defaultInterface
{
    static dispatch_once_t pred = 0;
    static MJCloudinaryInterface *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[MJCloudinaryInterface alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _cloudinary = [[CLCloudinary alloc] init];
        _fileFormat = MJCloudinaryImageFileFormatJPG;
        _radiusFileFormat = MJCloudinaryImageFileFormatPNG;
        _jpgCompressionQuality = 1.0;
    }
    return self;
}

#pragma mark Properties

- (void)setCloudName:(NSString *)cloudName
{
    [_cloudinary.config setObject:cloudName forKey:@"cloud_name"];
}

- (void)setApiKey:(NSString *)apiKey
{
    [_cloudinary.config setObject:apiKey forKey:@"api_key"];
}

- (void)setApiSecret:(NSString *)apiSecret
{
    [_cloudinary.config setObject:apiSecret forKey:@"api_secret"];
}

- (NSString*)cloudName
{
    return _cloudinary.config[@"cloud_name"];
}

- (NSString*)apiKey
{
    return _cloudinary.config[@"api_key"];
}

- (NSString*)apiSecret
{
    return _cloudinary.config[@"api_secret"];
}

#pragma mark Public Methods

- (BOOL)uploadImage:(id)image options:(NSDictionary*)options
{
    return [self uploadImage:image options:options progress:nil completion:nil];
}

- (BOOL)uploadImage:(id)image options:(NSDictionary*)options progress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(NSDictionary *result, NSString *cloudinaryId, NSString *error))completionBlock
{
    if (!image)
    {
        if (_enableDebugLogs)
            NSLog(@"[MJCloudinaryInterface] IMAGE UPLOAD: Could not upload nil image.");
        
        if (completionBlock)
            completionBlock(nil, nil, nil);
        
        return NO;
    }
        
    NSData *imageData = nil;
    if ([image isKindOfClass:UIImage.class])
    {
        if (_enableDebugLogs)
            NSLog(@"[MJCloudinaryInterface] IMAGE UPLOAD: Compressing image to JPG at 0.7 compression quality rate.");
        imageData = UIImageJPEGRepresentation(image, 0.7);
    }
    
    if (_enableDebugLogs)
        NSLog(@"[MJCloudinaryInterface] IMAGE UPLOAD: Uploading image with bytes length : %ld", (long)imageData.length);

    CLUploader *uploader = [[CLUploader alloc] init:_cloudinary delegate:nil];
    [uploader upload:imageData?imageData:image options:options withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
        
        if (_enableDebugLogs)
        {
            if (errorResult)
                NSLog(@"[MJCloudinaryInterface] IMAGE UPLOAD: Uploading finished with error: %@", [errorResult description]);
            else
                NSLog(@"[MJCloudinaryInterface] IMAGE UPLOAD: Uploading finished with result: %@", [successResult description]);
        }
        
        if (!errorResult)
            completionBlock(successResult, successResult[@"public_id"], nil);
        else
            completionBlock(nil, nil, errorResult);
    } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
        if (progressBlock)
        {
            CGFloat progress = ((CGFloat)totalBytesWritten)/(CGFloat)totalBytesExpectedToWrite;
            progressBlock(progress);
        }
    }];
    
    return YES;
}

- (NSURL*)URLForImageKey:(NSString *)imageKey
{
    if (imageKey == nil)
        return nil;
    
    if ([imageKey hasPrefix:@"http"])
    {
        if (_enableDebugLogs)
            NSLog(@"[MJCloudinaryInterface] URL CREATION: The used image key is already a URL: %@",imageKey);
        
        return [NSURL URLWithString:imageKey];
    }
    
    NSString *url = nil;
    
    if (_jpgCompressionQuality < 1.0)
    {
        CLTransformation *transformation = [CLTransformation transformation];
        transformation.quality = @(_jpgCompressionQuality*100);
        url = [_cloudinary url:imageKey options:@{@"transformation" : transformation}];
    }
    else
    {
        url = [_cloudinary url:imageKey];
    }
    
    if (_enableDebugLogs)
        NSLog(@"[MJCloudinaryInterface] URL CREATION:\n{\n\tkey:%@\n}\nURL: %@\n",imageKey, url);
    
    return [NSURL URLWithString:url];
}

- (NSURL*)URLForImageKey:(NSString*)imageKey size:(CGSize)size cropMode:(MJCloudinaryImageCropMode)cropMode radius:(CGFloat)radius;
{
    return [self URLForImageKey:imageKey size:size scale:[[UIScreen mainScreen] scale] cropMode:cropMode radius:radius];
}

- (NSURL*)URLForImageKey:(NSString*)imageKey size:(CGSize)size scale:(CGFloat)scale cropMode:(MJCloudinaryImageCropMode)cropMode radius:(CGFloat)radius;
{
    if (imageKey == nil)
        return nil;
    
    if ([imageKey hasPrefix:@"http"])
    {
        if (_enableDebugLogs)
            NSLog(@"[MJCloudinaryInterface] URL CREATION: The used image key is already a URL: %@",imageKey);
        
        return [NSURL URLWithString:imageKey];
    }
    
    CLTransformation *transformation = [self mjz_transformationForSize:size scale:scale cropMode:cropMode radius:radius];
    
    if (_jpgCompressionQuality < 1.0)
        transformation.quality = @(_jpgCompressionQuality*100);
    
    NSString *url = [_cloudinary url:imageKey options:@{@"transformation": transformation}];
    
    if (_enableDebugLogs)
        NSLog(@"[MJCloudinaryInterface] URL CREATION:\n{\n\tkey:%@,\n\tsize:%@,\n\tscale:%.2f,\n\tcrop_mode:%ld,\n\tradius:%.2f,\n}\nURL: %@\n",imageKey, NSStringFromCGSize(size), scale, (long)cropMode, radius, url);
    
    return [NSURL URLWithString:url];
}

- (NSURL*)URLForImageKey:(NSString*)imageKey
        pretransformCrop:(CGRect)pretransformCropRect
                    size:(CGSize)size
                   scale:(CGFloat)scale
                cropMode:(MJCloudinaryImageCropMode)cropMode
                  radius:(CGFloat)radius;
{
    if (imageKey == nil)
        return nil;
    
    CLTransformation *regularTransformation = [self mjz_transformationForSize:size scale:scale cropMode:cropMode radius:radius];

    if (_jpgCompressionQuality < 1.0)
        regularTransformation.quality = @(_jpgCompressionQuality*100);
    
    if (CGRectEqualToRect(pretransformCropRect, CGRectZero))
    {
        NSString *url = [_cloudinary url:imageKey options:@{@"transformation": regularTransformation}];
        return [NSURL URLWithString:url];
    }
    
    CLTransformation *cropTransformation = [CLTransformation transformation];
    
    [cropTransformation setX:@(pretransformCropRect.origin.x)];
    [cropTransformation setY:@(pretransformCropRect.origin.y)];
    [cropTransformation setWidth:@(pretransformCropRect.size.width)];
    [cropTransformation setHeight:@(pretransformCropRect.size.height)];
    [cropTransformation setCrop:@"crop"];
    
    NSString *url1 = [_cloudinary url:imageKey options:@{@"transformation": cropTransformation}];
    NSString *url2 = [_cloudinary url:imageKey options:@{@"transformation": regularTransformation}];

    NSArray *pathComponents = [url2 pathComponents];
    NSString *last2Components = [pathComponents[pathComponents.count-2] stringByAppendingPathComponent:pathComponents[pathComponents.count-1]];
    
    NSString *finalUrl = [[url1 stringByDeletingLastPathComponent] stringByAppendingPathComponent:last2Components];
    
//    http://res.cloudinary.com/dkzkltsvs/image/upload/x_0,y_0,h_640,w_640,c_crop/c_fill,f_png,g_center,h_100,r_max,w_100/vj0wfi6nok3esd87j1x4
    
    if (_enableDebugLogs)
        NSLog(@"[MJCloudinaryInterface] URL CREATION:\n{\n\tkey:%@,\n\tpre_transform_crop:%@,\n\tsize:%@,\n\tscale:%.2f,\n\tcrop_mode:%ld,\n\tradius:%.2f,\n}\nURL: %@\n",imageKey, NSStringFromCGRect(pretransformCropRect), NSStringFromCGSize(size), scale, (long)cropMode, radius, finalUrl);
    
    return [NSURL URLWithString:finalUrl];
}

#pragma mark Private Methods

- (CLTransformation*)mjz_transformationForSize:(CGSize)size scale:(CGFloat)scale cropMode:(MJCloudinaryImageCropMode)cropMode radius:(CGFloat)radius
{
    CLTransformation *transformation = [CLTransformation transformation];
    
    [transformation setWidthWithInt:ceilf(size.width * scale)];
    [transformation setHeightWithInt:ceilf(size.height * scale)];
    
    if (radius > 0)
    {
        if (radius == MJImageRadiusMax)
            transformation.radius = @"max";
        else
            [transformation setRadiusWithInt:ceilf(radius)];
        
        if (_radiusFileFormat)
            transformation.fetchFormat = _radiusFileFormat;
    }
    else
    {
        if (_fileFormat)
            transformation.fetchFormat = _fileFormat;
    }
    
    switch (cropMode)
    {
        case MJCloudinaryImageCropModeScaleToFill:
            transformation.crop = @"scale";
            break;
        case MJCloudinaryImageCropModeScaleAspectFill:
            transformation.crop = @"fill";
            transformation.gravity = @"center";
            break;
        case MJCloudinaryImageCropModeScaleAspectFit:
            transformation.crop = @"fit";
            break;
        case MJCloudinaryImageCropModeCenter:
            transformation.crop = @"crop";
            transformation.gravity = @"center";
            break;
        case MJCloudinaryImageCropModeTop:
            transformation.crop = @"fill";
            transformation.gravity = @"north";
            break;
        case MJCloudinaryImageCropModeBottom:
            transformation.crop = @"fill";
            transformation.gravity = @"south";
            break;
        case MJCloudinaryImageCropModeLeft:
            transformation.crop = @"fill";
            transformation.gravity = @"west";
            break;
        case MJCloudinaryImageCropModeRight:
            transformation.crop = @"fill";
            transformation.gravity = @"east";
            break;
        case MJCloudinaryImageCropModeTopLeft:
            transformation.crop = @"fill";
            transformation.gravity = @"north_west";
            break;
        case MJCloudinaryImageCropModeTopRight:
            transformation.crop = @"fill";
            transformation.gravity = @"north_east";
            break;
        case MJCloudinaryImageCropModeBottomLeft:
            transformation.crop = @"fill";
            transformation.gravity = @"south_west";
            break;
        case MJCloudinaryImageCropModeBottomRight:
            transformation.crop = @"fill";
            transformation.gravity = @"south_east";
            break;
        case MJCloudinaryImageCropModeFace:
            transformation.crop = @"thumb";
            transformation.gravity = @"face";
            break;
        case MJCloudinaryImageCropModeFaces:
            transformation.crop = @"thumb";
            transformation.gravity = @"faces";
            break;
    }
    
    return transformation;
}

@end
