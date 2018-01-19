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

#import "CLUploader+Additions.h"

@implementation CLUploader (Additions)

- (BOOL)uploadImage:(UIImage*)image
             format:(CLUploaderFormat)format
    compressionRate:(CGFloat)compressionRate
{
    return [self uploadImage:image format:format compressionRate:compressionRate progress:nil completion:nil];
}

- (BOOL)uploadImage:(UIImage*)image
             format:(CLUploaderFormat)format
    compressionRate:(CGFloat)compressionRate
           progress:(CLUploaderProgressBlock)progressBlock
         completion:(CLUploaderCompletionBlock)completionBlock
{
    NSData *imageData = nil;
    
    if (format == CLUploaderFormatJPG)
    {
        imageData = UIImageJPEGRepresentation(image, compressionRate);
    }
    else //if (format == CLUploaderFormatPNG)
    {
        imageData = UIImagePNGRepresentation(image);
    }
    
    [self upload:imageData?imageData:image options:nil withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
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

@end
