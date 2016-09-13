//
// Created by Paolo Tagliani on 13/09/16.
// Copyright (c) 2016 MobileJazz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@interface MJPDFViewerDataSource : NSObject <QLPreviewControllerDataSource>

- (instancetype)initWithFilename:(NSString *)filename;

@property (nonatomic, strong, readwrite) NSString *title;

@end