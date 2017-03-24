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

#import <Foundation/Foundation.h>

/**
 * MVP View protocol. To be implemented in UIViewController instances and used from presenters.
 **/
@protocol MJViewControllerPresenterView <NSObject>

/**
 * The title of the view (typically, the UIViewController's title property).
 **/
@property (nonatomic, readwrite) NSString *title;

/**
 * The view's undo manager (typically, the UIViewController's undoManager property)
 **/
- (NSUndoManager*)undoManager;

/**
 * Default method for view reload.
 **/
- (void)onReloadView;

/**
 * Default error handler
 **/
- (void)onDisplayError:(NSError*)error;

@end

/**
 * MVP Presenter super class.
 **/
@interface MJViewControllerPresenter : NSObject

/** *************************************** **
 * @name Initializers
 ** *************************************** **/

/**
 * Default initializer.
 * @param view The view
 **/
- (instancetype)initWithView:(id <MJViewControllerPresenterView>)view NS_DESIGNATED_INITIALIZER;

/** *************************************** **
 * @name Main Properites
 ** *************************************** **/

@property (nonatomic, weak) id <MJViewControllerPresenterView> view;

/** *************************************** **
 * @name View life cycle.
 ** *************************************** **/

- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
