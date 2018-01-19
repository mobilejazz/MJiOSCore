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

#import "CLTransformation+Additions.h"

@interface CLCloudinary (Additions)

+ (CLCloudinary*)defaultCloudinary;
+ (void)setDefaultCloudinary:(CLCloudinary*)cloudinary;

@property (nonatomic, readwrite) NSString *cloudName;
@property (nonatomic, readwrite) NSString *apiKey;
@property (nonatomic, readwrite) NSString *apiSecret;
@property (nonatomic, readwrite, getter=isSubdomainsEnabled) BOOL subdomainsEnabled;

- (NSURL*)urlForImageWithId:(NSString *)imageId;
- (NSURL*)urlForImageWithId:(NSString*)imageId
             transformation:(CLTransformation*)transformation;

- (NSURL*)urlForImageWithId:(NSString*)imageId
                       size:(CGSize)size
                   cropMode:(CLCloudinaryCropMode)cropMode;

- (NSURL*)urlForImageWithId:(NSString*)imageId
                       size:(CGSize)size
                      scale:(CGFloat)scale
                   cropMode:(CLCloudinaryCropMode)cropMode;

@end
