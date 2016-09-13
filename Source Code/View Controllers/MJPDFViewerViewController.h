//
// Created by Paolo Tagliani on 13/09/16.
// Copyright (c) 2016 MobileJazz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@interface MJPDFViewerViewController : QLPreviewController <QLPreviewControllerDelegate>

/**
 *  Document title to be visualized in navigation bar. If set to nil, uses the name of the file.
 */
@property (strong, nonatomic, readwrite) NSString *documentTitle;

/**
 *  Load from the bundle the file named as parameter
 *
 *  @param filename The name of the PDF file to show
 */
- (void)setupWithFilename:(NSString *)filename;

@end