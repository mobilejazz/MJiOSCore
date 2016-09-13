//
// Created by Paolo Tagliani on 13/09/16.
// Copyright (c) 2016 MobileJazz. All rights reserved.
//

#import "MJPDFViewerDataSource.h"

@interface ALPDFItem : NSObject <QLPreviewItem>

- (instancetype)initWithTitle:(NSString *)title url:(NSURL *)url;

@end

@implementation ALPDFItem {
    NSString *_title;
    NSURL *_url;
}

- (instancetype)initWithTitle:(NSString *)title url:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        _title = title;
        _url = url;
    }
    
    return self;
}

- (NSURL *)previewItemURL
{
    return _url;
}

- (NSString *)previewItemTitle
{
    return _title;
}

@end

@implementation MJPDFViewerDataSource {
    NSString *_filename;
}

- (instancetype)initWithFilename:(NSString *)filename
{
    self = [super init];
    if (self)
    {
        _filename = filename;
    }
    
    return self;
}

#pragma mark - Private methods
#pragma mark QLPreviewControllerDataSource

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSString *path = [[NSBundle mainBundle] pathForResource:_filename ofType:@"pdf"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    return [[ALPDFItem alloc] initWithTitle:_title url:fileURL];
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}


@end