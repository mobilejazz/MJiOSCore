//
//  MJViewController.m
//  MJiOSCore
//
//  Created by Joan Martin on 01/19/2018.
//  Copyright (c) 2018 Joan Martin. All rights reserved.
//

#import "MJViewController.h"
#import <MJiOSCore/MJiOSCore.h>
//@import MJiOSCore
//#import "UIView+Additions.h"

@interface MJBViewController ()

@end

@implementation MJBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *someView = [[UIView alloc] initWithFrame:CGRectZero];
    someView.translatesAutoresizingMaskIntoConstraints = NO;
    someView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:someView];
    NSArray<NSLayoutConstraint *> *constraints =
  @[
    [someView.leadingAnchor constraintEqualToAnchor:self.view.readableContentGuide.leadingAnchor],
    [someView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80],
    [someView.widthAnchor constraintEqualToConstant:200],
    [someView.heightAnchor constraintEqualToConstant:50],
    ];
    [NSLayoutConstraint activateConstraints:constraints];
    CGFloat lineWidth = 2;
    CGFloat margins = 0;
    [someView add_separatorViewAtPosition:NTSeparatorPositionLeading withColor:UIColor.blueColor thickness:lineWidth margin:margins];
    [someView add_separatorViewAtPosition:NTSeparatorPositionTop withColor:UIColor.redColor thickness:lineWidth margin:margins];
    [someView add_separatorViewAtPosition:NTSeparatorPositionTrailing withColor:UIColor.yellowColor thickness:lineWidth margin:margins];
    [someView add_separatorViewAtPosition:NTSeparatorPositionBottom withColor:UIColor.purpleColor thickness:lineWidth margin:margins];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
