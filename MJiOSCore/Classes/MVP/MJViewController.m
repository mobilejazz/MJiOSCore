//
// Copyright 2017 Mobile Jazz SL
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
#import "MJViewController.h"

@interface MJViewController ()

@end

@implementation MJViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {        
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presenter.view = self;
    
    [self mjz_delayWithPresenter:_presenter block:^(MJViewControllerPresenter *presenter) {
        [presenter viewDidLoad];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self mjz_delayWithPresenter:_presenter block:^(MJViewControllerPresenter *presenter) {
        [presenter viewWillAppear:animated];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self mjz_delayWithPresenter:_presenter block:^(MJViewControllerPresenter *presenter) {
        [presenter viewDidAppear:animated];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self mjz_delayWithPresenter:_presenter block:^(MJViewControllerPresenter *presenter) {
        [presenter viewWillDisappear:animated];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self mjz_delayWithPresenter:_presenter block:^(MJViewControllerPresenter *presenter) {
        [presenter viewDidDisappear:animated];
    }];
}

#pragma mark Private Methods

- (void)mjz_delayWithPresenter:(MJViewControllerPresenter*)presenter block:(void (^)(MJViewControllerPresenter *presenter))block
{
    if (presenter)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            block(presenter);
        });
    }
}

#pragma mark - Protocols
#pragma mark MJViewControllerPresenterView

- (void)onReloadView
{
    // Subclasses may override
}

- (void)onDisplayError:(NSError *)error
{
    // Subclasses may override
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
