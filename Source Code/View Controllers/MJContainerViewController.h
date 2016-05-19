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

typedef NS_ENUM(NSUInteger, MJContainerAnimation)
{
    MJContainerAnimationNone,
    MJContainerAnimationCrossDissolve,
    MJContainerAnimationNewModalBottom,
    MJContainerAnimationOldModalBottom,
};

/**
 * This simple container view controller displays a single view controller. 
 * It is possible to replace the displayed view controller for a new view controller and this action can be done animatedly.
 * @discussion This class works best being the window.rootViewController. This way the first displayed view controller can be replaced animatedly.
 **/
@interface MJContainerViewController : UIViewController

/**
 * Default initializer.
 * @param viewController The view controller to show.
 * @return The initialized instance.
 **/
- (id)initWithViewController:(UIViewController*)viewController;

/**
 * The current shown view controller.
 **/
@property (nonatomic, strong) UIViewController *viewController;

/**
 * Sets the new view controller animated.
 * @param viewController The new view controller
 * @param animation The animation.
 **/
- (void)setViewController:(UIViewController *)viewController animation:(MJContainerAnimation)animation;

/**
 * Sets the new view controller animated.
 * @param viewController The new view controller
 * @param animation The animation.
 * @param completionBlock The completion block of the animation.
 **/
- (void)setViewController:(UIViewController *)viewController animation:(MJContainerAnimation)animation completionBlock:(void (^)())completionBlock;

@end

/**
 * UIViewController+MJContainerViewController category.
 **/
@interface UIViewController (MJContainerViewController)

/**
 * Returns the first container view controller in the view controller hierarchy.
 * @return The first container view controller.
 **/
- (MJContainerViewController*)mjz_containerViewController;

@end
