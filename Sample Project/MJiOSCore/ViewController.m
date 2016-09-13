//
//  ViewController.m
//  MJiOSCore
//
//  Created by Joan Martin on 19/05/16.
//  Copyright © 2016 MobileJazz. All rights reserved.
//

#import "ViewController.h"
#import "MJPDFViewerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testPDFReader:(id)sender
{
    MJPDFViewerViewController *PDFViewer = [[MJPDFViewerViewController alloc] init];
    
    [PDFViewer setupWithFilename:@"testfile"];
    PDFViewer.documentTitle = @"Test";
    [self presentViewController:PDFViewer animated:YES completion:nil];
}


@end
