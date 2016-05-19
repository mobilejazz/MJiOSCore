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
 * Additions to UIView.
 **/
@interface UIView (Additions)

/** ************************************************************ **
 * @name Finding next responder
 ** ************************************************************ **/

/**
 * Returns the next UITextField or UITextView located inside the next UITableViewCells on a same UITableView section.
 * @return A candidate to next first responder.
 * @discussion The receiver view must be located inside a table view cell, and the cell must be located inside a table view.
 **/
- (nullable __kindof UIView*)add_nextFirstResponder;

/** ************************************************************ **
 * @name Finding subviews
 ** ************************************************************ **/

/**
 * Returns the first subview with the given accessibility identifier.
 * @param identifier The accessibility identifier.
 * @return The subview that matches the passed arguments.
 **/
- (nullable __kindof UIView*)add_subviewWithAccessibilityIdentifier:(nonnull NSString*)identifier;

/**
 * Returns all subviews with the given accessibility identifier.
 * @param identifier The accessibility identifier.
 * @return The subviews that matches the passed arguments.
 **/
- (nonnull NSArray<__kindof UIView*>*)add_subviewsWithAccessibilityIdentifier:(nonnull NSString*)identifier;

/**
 * Enumerates all subviews with the given accessibility identifier.
 * @param identifier The accessibility identifier.
 * @param block The object enumeration block
 **/
- (void)add_enumerateSubviewsWithAccessibilityIdentifier:(nonnull NSString*)identifier
                                                 objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block;

/**
 * Returns the first subview with the given tag.
 * @param tag The tag.
 * @return The subview that matches the passed arguments.
 **/
- (nullable __kindof UIView*)add_subviewWithTag:(NSInteger)tag;

/**
 * Returns all subviews with the given tag.
 * @param tag The tag.
 * @return The subviews that matches the passed arguments.
 **/
- (nonnull NSArray<__kindof UIView*>*)add_subviewsWithTag:(NSInteger)tag;

/**
 * Enumerates all subviews with the given tag.
 * @param tag The tag.
 * @param block The object enumeration block
 **/
- (void)add_enumerateSubviewsWithTag:(NSInteger)tag
                             objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block;

/**
 * Returns the first subview of the given class.
 * @param clazz The class.
 * @return The subview that matches the passed arguments.
 **/
- (nullable __kindof UIView*)add_subviewOfClass:(nonnull Class)clazz;

/**
 * Returns all subviews of the given class.
 * @param clazz The class.
 * @return The subviews that matches the passed arguments.
 **/
- (nonnull NSArray<__kindof UIView*>*)add_subviewsOfClass:(nonnull Class)clazz;

/**
 * Enumerates all subviews of the given class.
 * @param clazz The class.
 * @param block The object enumeration block
 **/
- (void)add_enumerateSubviewsOfClass:(nonnull Class)clazz
                             objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block;

/**
 * Enumerate all subviews in the hierarchy tree.
 * @return An array with all views in the subtree of views form the receiver.
 **/
- (nonnull NSArray<__kindof UIView*>*)add_allSubviews;

/**
 * Enumerate all subviews in the hierarchy tree.
 * @param block The object enumeration block
 **/
- (void)add_enumerateAllSubviews:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block;

/**
 * Returns the first subview passing the test.
 * @param testBlock The test block
 * @return The subview that matches the passed arguments.
 **/
- (nullable __kindof UIView*)add_subviewPassingTest:(BOOL (^_Nonnull)(__kindof UIView * _Nonnull view))testBlock;

/**
 * Returns all subviews that passes the given test.
 * @param testBlock The test block
 * @return An array with the subview that matches the passed arguments.
 **/
- (nonnull NSArray<__kindof UIView*>*)add_subviewsPassingTest:(BOOL (^_Nonnull)(__kindof UIView * _Nonnull view))testBlock;

/**
 * Enumerates all subviews that passes the given test.
 * @param testBlock The test block
 * @param block The object enumeration block
 **/
- (void)add_enumerateSubviewsPassingTest:(BOOL (^_Nonnull)(__kindof UIView * _Nonnull view))testBlock
                                 objects:(void (^_Nonnull)(__kindof UIView * _Nonnull view, BOOL * _Nullable stop))block;

/** ************************************************************ **
 * @name Geometry
 ** ************************************************************ **/

/**
 * Defines the view's layer anchor point using a [0..1] range.
 * @param anchorPoint A CGPoint with a [0..1] range.
 **/
- (void)add_setAnchorPoint:(CGPoint)anchorPoint;

/** ************************************************************ **
 * @name Rendering
 ** ************************************************************ **/

/**
 * Creates a UIImage with the view.
 * @return An image with the rendered view.
 **/
- (nullable UIImage *)add_imageByRenderingView;

@end
