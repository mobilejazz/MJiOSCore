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

#import <UIKit/UIKit.h>

/**
 * Custom container view controller that contains a UITableViewController and exposes all its methods and properties.
 * Useful when desiring a UIViewController but not UITableViewController subclass and wanting to use a native supported UIRefreshControl.
 **/
@interface MJTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStyle:(UITableViewStyle)style;

- (id)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL clearsSelectionOnViewWillAppear;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
