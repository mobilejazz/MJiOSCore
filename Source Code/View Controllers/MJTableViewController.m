//
// Copyright 2014 Mobile Jazz SL
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

#import "MJTableViewController.h"

@interface MJTableViewController ()

@property (nonatomic, strong) UITableViewController *tableViewController;

@end

@implementation MJTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStyle:(UITableViewStyle)style
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self tfm_initWithStyle:style];
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        [self tfm_initWithStyle:style];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self tfm_initWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)dealloc
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_tableViewController.tableView.style == UITableViewStylePlain)
        self.view.backgroundColor = [UIColor whiteColor];
    else
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *subview = _tableViewController.view;
    subview.backgroundColor = [UIColor clearColor];
    subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subview.frame = self.view.bounds;
        
    [self.view addSubview:subview];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    if (parent != nil)
        [self addChildViewController:_tableViewController];
    else
        [_tableViewController willMoveToParentViewController:nil];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    if (parent != nil)
        [_tableViewController didMoveToParentViewController:self];
    else
        [_tableViewController removeFromParentViewController];
}

#pragma mark Properties

- (UITableView*)tableView
{
    return _tableViewController.tableView;
}

- (void)setTableView:(UITableView *)tableView
{
    _tableViewController.tableView = tableView;
}

- (void)setClearsSelectionOnViewWillAppear:(BOOL)clearsSelectionOnViewWillAppear
{
    _tableViewController.clearsSelectionOnViewWillAppear = clearsSelectionOnViewWillAppear;
}

- (BOOL)clearsSelectionOnViewWillAppear
{
    return _tableViewController.clearsSelectionOnViewWillAppear;
}

- (void)setRefreshControl:(UIRefreshControl *)refreshControl
{
    _tableViewController.refreshControl = refreshControl;
}

- (UIRefreshControl*)refreshControl
{
    return _tableViewController.refreshControl;
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets
{
    [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
    _tableViewController.automaticallyAdjustsScrollViewInsets = automaticallyAdjustsScrollViewInsets;
}

#pragma mark Private Methods

- (void)tfm_initWithStyle:(UITableViewStyle)style
{
    _tableViewController = [[UITableViewController alloc] initWithStyle:style];
    _tableViewController.tableView.delegate = self;
    _tableViewController.tableView.dataSource = self;
}

#pragma mark - Protocols

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
