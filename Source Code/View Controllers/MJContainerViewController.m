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

#import "MJContainerViewController.h"

#define ANIMATION_CURVE     (7 << 16)
#define ANIMATION_DURATION  0.40

@interface MJContainerViewController ()

@end

@implementation MJContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithViewController:nil];
}

- (id)initWithViewController:(UIViewController*)viewController;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _viewController = viewController;
    }
    return self;
}

//- (void)dealloc
//{
//    // Nothing needs to be done
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *subview = _viewController.view;
    subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subview.frame = self.view.bounds;
    
    [self.view addSubview:subview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    if (parent != nil)
        [self addChildViewController:_viewController];
    else
        [_viewController willMoveToParentViewController:nil];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    if (parent != nil)
        [_viewController didMoveToParentViewController:self];
    else
        [_viewController removeFromParentViewController];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (_viewController)
        return _viewController.preferredStatusBarStyle;
    
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    if (_viewController)
        return _viewController.shouldAutorotate;
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (_viewController)
        return _viewController.supportedInterfaceOrientations;
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark Properties

- (void)setViewController:(UIViewController *)viewController
{
    [self setViewController:viewController animation:MJContainerAnimationNone];
}

#pragma mark Public Methods

- (void)setViewController:(UIViewController *)viewController animation:(MJContainerAnimation)animation
{
    [self setViewController:viewController animation:animation completionBlock:nil];
}

- (void)setViewController:(UIViewController *)viewController animation:(MJContainerAnimation)animation completionBlock:(void (^)())completionBlock
{
    UIViewController *oldVC = _viewController;
    UIViewController *newVC = viewController;
    
    _viewController = viewController;
    
    if (self.isViewLoaded)
    {
        BOOL inHerarchy = YES;
        
        void (^beforeAnimation)() = ^ {
            if (inHerarchy)
            {
                [oldVC willMoveToParentViewController:nil];
                
                if (newVC)
                    [self addChildViewController:newVC];
            }
        };
        
        void (^afterAnimation)() = ^ {
            if (inHerarchy)
            {
                [oldVC removeFromParentViewController];
                [newVC didMoveToParentViewController:self];
            }
            
            // Call completion block
            if (completionBlock)
                completionBlock();
        };
        
        beforeAnimation();
        
        if (animation == MJContainerAnimationCrossDissolve)
        {
            [self.view insertSubview:newVC.view belowSubview:oldVC.view];
            
            [UIView animateWithDuration:ANIMATION_DURATION
                                  delay:0.0
                                options:ANIMATION_CURVE
                             animations:^{
                                 oldVC.view.alpha = 0.0f;
                             } completion:^(BOOL finished) {
                                 [oldVC.view removeFromSuperview];
                                 afterAnimation();
                             }];
        }
        else if (animation == MJContainerAnimationNewModalBottom)
        {
            newVC.view.alpha = 0.0f;
            newVC.view.frame = CGRectOffset(oldVC.view.frame, 0, oldVC.view.frame.size.height);
            [self.view insertSubview:newVC.view aboveSubview:oldVC.view];
            
            [UIView animateWithDuration:ANIMATION_DURATION
                                  delay:0.0
                                options:ANIMATION_CURVE
                             animations:^{
                                 newVC.view.alpha = 1.0f;
                                 newVC.view.frame = oldVC.view.frame;
                             } completion:^(BOOL finished) {
                                 [oldVC.view removeFromSuperview];
                                 afterAnimation();
                             }];
            
        }
        else if (animation == MJContainerAnimationOldModalBottom)
        {
            CGRect frame = CGRectOffset(oldVC.view.frame, 0, oldVC.view.frame.size.height);
            [self.view insertSubview:newVC.view belowSubview:oldVC.view];
            
            [UIView animateWithDuration:ANIMATION_DURATION
                                  delay:0.0
                                options:ANIMATION_CURVE
                             animations:^{
                                 oldVC.view.frame = frame;
                                 oldVC.view.alpha = 0.0f;
                             } completion:^(BOOL finished) {
                                 [oldVC.view removeFromSuperview];
                                 afterAnimation();
                             }];
        }
        else// if (animation == MJContainerAnimationNone)
        {
            [oldVC.view removeFromSuperview];
            [self.view insertSubview:newVC.view atIndex:0];
            afterAnimation();
        }
    }
    else
    {
        NSAssert(self.parentViewController == nil, @"If the view controller view's is not loaded, the view controller cannot be in the VC hierarchy!");
    }
}

@end


@implementation UIViewController (MJContainerViewController)

- (MJContainerViewController*)mjz_containerViewController
{
    UIViewController *vc = self;
    
    while (vc != nil)
    {
        if ([vc isKindOfClass:MJContainerViewController.class])
            return (MJContainerViewController*)vc;
        
        vc = vc.parentViewController;
    }
    
    return nil;
}

@end
