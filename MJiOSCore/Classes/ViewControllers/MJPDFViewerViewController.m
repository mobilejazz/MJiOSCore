//
// Created by Paolo Tagliani on 13/09/16.
// Copyright (c) 2016 MobileJazz. All rights reserved.
//

#import "MJPDFViewerViewController.h"
#import "MJPDFViewerDataSource.h"

@interface MJPDFViewerViewController ()

// Data source needs to be retained since the original property is assign
@property (strong, nonatomic, readwrite) id<QLPreviewControllerDataSource> retainedDataSource;

@end


@implementation MJPDFViewerViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
}

#pragma mark - Public methods

- (void)setupWithFilename:(NSString *)filename
{
    self.retainedDataSource = [[MJPDFViewerDataSource alloc] initWithFilename:filename];
    self.dataSource = _retainedDataSource;
    ((MJPDFViewerDataSource *) self.retainedDataSource).title = _documentTitle;
}

- (void)setDocumentTitle:(NSString *)documentTitle
{
    _documentTitle = documentTitle;
    ((MJPDFViewerDataSource *) self.retainedDataSource).title = documentTitle;
}

@end