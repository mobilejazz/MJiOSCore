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

#import "CLTransformation+Additions.h"

CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPNG  = @"png";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatJPG  = @"jpg";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatGIF  = @"gif";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatBMP  = @"bmp";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatTIFF = @"tiff";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatICO  = @"ico";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPDF  = @"pdf";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatEPS  = @"eps";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatPSD  = @"psd";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatSVG  = @"svg";
CLCloudinaryFetchFormat * const CLCloudinaryFetchFormatWEBP = @"webp";


static CLCloudinaryFetchFormat * __defaultFetchFormat = nil;
static CGFloat __defaultQuality = 100;

@implementation CLTransformation (Additions)

+ (void)setDefaultFetchFormat:(CLCloudinaryFetchFormat*)fetchFormat
{
    __defaultFetchFormat = fetchFormat;
}

+ (void)setDefaultQualityRate:(CGFloat)qualityRate
{
    __defaultQuality = qualityRate * 100;
}

+ (CLTransformation*)defaultTransformation
{
    CLTransformation *transformation = [[CLTransformation alloc] init];
    
    if (__defaultFetchFormat != nil)
        [transformation setFetchFormat:__defaultFetchFormat];
    
    if (__defaultQuality < 100 && __defaultQuality > 0)
        [transformation setQuality:@(__defaultQuality)];
    
    return transformation;
}

+ (CLTransformation*)transformationForCropMode:(CLCloudinaryCropMode)cropMode
{
    CLTransformation *transformation = [CLTransformation defaultTransformation];
    [transformation setCropMode:cropMode];
    
    return transformation;
}

- (void)setCropMode:(CLCloudinaryCropMode)cropMode
{
    switch (cropMode)
    {
        case CLCloudinaryCropModeScaleToFill:
            self.crop = @"scale";
            break;
        case CLCloudinaryCropModeScaleAspectFill:
            self.crop = @"fill";
            self.gravity = @"center";
            break;
        case CLCloudinaryCropModeScaleAspectFit:
            self.crop = @"fit";
            break;
        case CLCloudinaryCropModeCenter:
            self.crop = @"crop";
            self.gravity = @"center";
            break;
        case CLCloudinaryCropModeTop:
            self.crop = @"fill";
            self.gravity = @"north";
            break;
        case CLCloudinaryCropModeBottom:
            self.crop = @"fill";
            self.gravity = @"south";
            break;
        case CLCloudinaryCropModeLeft:
            self.crop = @"fill";
            self.gravity = @"west";
            break;
        case CLCloudinaryCropModeRight:
            self.crop = @"fill";
            self.gravity = @"east";
            break;
        case CLCloudinaryCropModeTopLeft:
            self.crop = @"fill";
            self.gravity = @"north_west";
            break;
        case CLCloudinaryCropModeTopRight:
            self.crop = @"fill";
            self.gravity = @"north_east";
            break;
        case CLCloudinaryCropModeBottomLeft:
            self.crop = @"fill";
            self.gravity = @"south_west";
            break;
        case CLCloudinaryCropModeBottomRight:
            self.crop = @"fill";
            self.gravity = @"south_east";
            break;
        case CLCloudinaryCropModeFace:
            self.crop = @"thumb";
            self.gravity = @"face";
            break;
        case CLCloudinaryCropModeFaces:
            self.crop = @"thumb";
            self.gravity = @"faces";
            break;
    }
}

@end
