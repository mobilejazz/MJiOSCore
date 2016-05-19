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

#import "CLCloudinary+Additions.h"

static CLCloudinary *_defaultCloudinary = nil;

@implementation CLCloudinary (Additions)

+ (CLCloudinary*)defaultCloudinary
{
    return _defaultCloudinary;
}

+ (void)setDefaultCloudinary:(CLCloudinary*)cloudinary
{
    _defaultCloudinary = cloudinary;
}

#pragma mark Properties

- (void)setCloudName:(NSString *)cloudName
{
    [self.config setObject:cloudName forKey:@"cloud_name"];
}

- (void)setApiKey:(NSString *)apiKey
{
    [self.config setObject:apiKey forKey:@"api_key"];
}

- (void)setApiSecret:(NSString *)apiSecret
{
    [self.config setObject:apiSecret forKey:@"api_secret"];
}

- (void)setSubdomainsEnabled:(BOOL)subdomainsEnabled
{
    [self.config setObject:@(subdomainsEnabled) forKey:@"cdn_subdomain"];
}

- (NSString*)cloudName
{
    return self.config[@"cloud_name"];
}

- (NSString*)apiKey
{
    return self.config[@"api_key"];
}

- (NSString*)apiSecret
{
    return self.config[@"api_secret"];
}

- (BOOL)isSubdomainsEnabled
{
    return self.config[@"cdn_subdomain"];
}

#pragma mark Public Methods

- (NSURL*)urlForImageWithId:(NSString *)imageId
{
    return [self urlForImageWithId:imageId transformation:nil];
}

- (NSURL*)urlForImageWithId:(NSString*)imageId transformation:(CLTransformation*)transformation
{
    if (imageId == nil)
        return nil;
    
    if ([imageId hasPrefix:@"http"])
        return [NSURL URLWithString:imageId];
    
    NSString *path = [self url:imageId options:@{@"transformation": transformation}];
    NSURL *url = [NSURL URLWithString:path];
    return url;
}

- (NSURL*)urlForImageWithId:(NSString*)imageId
                       size:(CGSize)size
                   cropMode:(CLCloudinaryCropMode)cropMode
{
    return [self urlForImageWithId:imageId
                              size:size
                             scale:[UIScreen mainScreen].scale
                          cropMode:cropMode];
}

- (NSURL*)urlForImageWithId:(NSString*)imageId
                       size:(CGSize)size
                      scale:(CGFloat)scale
                   cropMode:(CLCloudinaryCropMode)cropMode
{
    if (imageId == nil)
        return nil;
    
    if ([imageId hasPrefix:@"http"])
        return [NSURL URLWithString:imageId];
    
    CLTransformation *transformation = [CLTransformation transformationForCropMode:cropMode];
    
    [transformation setWidthWithFloat:size.width];
    [transformation setHeightWithFloat:size.height];
    [transformation setDprWithFloat:scale];
    
    NSURL *url = [self urlForImageWithId:imageId transformation:transformation];
    return url;
}

@end
