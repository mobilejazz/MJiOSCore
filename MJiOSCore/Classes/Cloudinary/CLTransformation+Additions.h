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

typedef NSString CLCloudinaryFetchFormat;

extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPNG;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatJPG;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatGIF;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatBMP;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatTIFF;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatICO;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPDF;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatEPS;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPSD;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatSVG;
extern CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatWEBP;

typedef NS_ENUM(NSUInteger, CLCloudinaryCropMode)
{
    CLCloudinaryCropModeScaleToFill       = UIViewContentModeScaleToFill,
    CLCloudinaryCropModeScaleAspectFit    = UIViewContentModeScaleAspectFit,
    CLCloudinaryCropModeScaleAspectFill   = UIViewContentModeScaleAspectFill,
    CLCloudinaryCropModeCenter            = UIViewContentModeCenter,
    CLCloudinaryCropModeTop               = UIViewContentModeTop,
    CLCloudinaryCropModeBottom            = UIViewContentModeBottom,
    CLCloudinaryCropModeLeft              = UIViewContentModeLeft,
    CLCloudinaryCropModeRight             = UIViewContentModeRight,
    CLCloudinaryCropModeTopLeft           = UIViewContentModeTopLeft,
    CLCloudinaryCropModeTopRight          = UIViewContentModeTopRight,
    CLCloudinaryCropModeBottomLeft        = UIViewContentModeBottomLeft,
    CLCloudinaryCropModeBottomRight       = UIViewContentModeBottomRight,
    CLCloudinaryCropModeFace              = 1000000,
    CLCloudinaryCropModeFaces             = 1000001,
};

@interface CLTransformation (Additions)

+ (void)setDefaultFetchFormat:(CLCloudinaryFetchFormat*)fetchFormat;
+ (void)setDefaultQualityRate:(CGFloat)qualityRate;

+ (CLTransformation*)defaultTransformation;

+ (CLTransformation*)transformationForCropMode:(CLCloudinaryCropMode)cropMode;

- (void)setCropMode:(CLCloudinaryCropMode)cropMode;

@end
