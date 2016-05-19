//
//  MJMultiToggleControl.h
//
//  Created by Joan Martin on 23/01/14.
//  Copyright (c) 2014 MobileJazz. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger UIMultiToggleControlSelectionNone;

/**
 * Behaving similar to a UISegmentedControl, this class is highly configurable.
 **/
@interface IB_DESIGNABLE MJMultiToggleControl : UIControl

/** ************************************************ **
 * @name Initializers
 ** ************************************************ **/

/**
 * Default initializer. 
 * @param frame The frame
 * @param toggleCount The number of buttons.
 * @return An initialized instance.
 * @discussion This class supports also initWithCoder. Therefore you can instantiate objects from interface builder.
 **/
- (id)initWithFrame:(CGRect)frame toggleCount:(NSInteger)toggleCount;

/** ************************************************ **
 * @name Selection
 ** ************************************************ **/

/**
 * Defines the selected toggle. Default value is  UIMultiToggleControlSelectionNone.
 **/
@property (nonatomic, assign) IBInspectable NSInteger selectedToggle;

/** ************************************************ **
 * @name Configuration
 ** ************************************************ **/

/**
 * The number of toggles to display.
 **/
@property (nonatomic, assign) IBInspectable NSInteger toggleCount;

/**
 * The separation between toggles. Default value is zero.
 **/
@property (nonatomic, assign) IBInspectable CGFloat toggleSeparation;

/**
 * Indicates if a none selection is possible or not. Default value is YES.
 **/
@property (nonatomic, assign) IBInspectable BOOL allowsSelectionNone;

/**
 * Returns the title for a state for a specific toggle.
 * @param state The state.
 * @param toggleIndex The index.
 * @return The title.
 **/
- (NSString*)titleForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title for a state for a specific toggle.
 * @param title The title to set.
 * @param state The state.
 * @param toggleIndex The index.
 **/
- (void)setTitle:(NSString*)string forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Returns the image for a state for a specific toggle.
 * @param state The state.
 * @param toggleIndex The index.
 * @return The image.
 **/
- (UIImage*)imageForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the image for a state for a specific toggle.
 * @param image The image to set.
 * @param state The state.
 * @param toggleIndex The index.
 **/
- (void)setImage:(UIImage*)image forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/** ************************************************ **
 * @name Style Configuration
 ** ************************************************ **/

/**
 * Returns the title font for a specific toggle.
 * @param toggleIndex The index.
 * @return The font.
 **/
- (UIFont*)titleFontForToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title font for a specific toggle.
 * @param font The font to set.
 * @param toggleIndex The index.
 **/
- (void)setTitleFont:(UIFont*)font forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title font for all toggles.
 * @param font The font to set.
 **/
- (void)setTitleFont:(UIFont*)font UI_APPEARANCE_SELECTOR;

/**
 * Returns the title color for a specific toggle for a given state.
 * @param state The state
 * @param toggleIndex The index.
 * @return The title color.
 **/
- (UIColor*)titleColorForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title color for a specific toggle for a given state.
 * @param color The color to set.
 * @param state The state.
 * @param toggleIndex The index.
 **/
- (void)setTitleColor:(UIColor*)color forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title color for all toggles for a given state.
 * @param font The color to set.
 * @param state The state.
 **/
- (void)setTitleColor:(UIColor*)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 * Returns the background image for a specific toggle for a given state.
 * @param state The state
 * @param toggleIndex The index.
 * @return The background image.
 **/
- (UIImage*)backgroundImageForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the background image for a specific toggle for a given state.
 * @param image The image to set.
 * @param state The state.
 * @param toggleIndex The index.
 **/
- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the background image for all toggles for a given state.
 * @param image The background image to set.
 * @param state The state.
 **/
- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 * Returns the title edge insets for a specific toggle.
 * @param toggleIndex The index.
 * @return The title edge instets.
 **/
- (UIEdgeInsets)titleEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title edge insets for a specific toggle.
 * @param edgeInsets The edge insets to set.
 * @param toggleIndex The index.
 **/
- (void)setTitleEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the title edge insets for all toggles.
 * @param edgeInsets The edge insets to set.
 **/
- (void)setTitleEdgeInsets:(UIEdgeInsets)edgeInsets UI_APPEARANCE_SELECTOR;

/**
 * Returns the content edge insets for a specific toggle.
 * @param toggleIndex The index.
 * @return The content edge instets.
 **/
- (UIEdgeInsets)contentEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the content edge insets for a specific toggle.
 * @param edgeInsets The edge insets to set.
 * @param toggleIndex The index.
 **/
- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the content edge insets for all toggles.
 * @param edgeInsets The edge insets to set.
 **/
- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets UI_APPEARANCE_SELECTOR;

/**
 * Returns the image edge insets for a specific toggle.
 * @param toggleIndex The index.
 * @return The image edge instets.
 **/
- (UIEdgeInsets)imageEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the image edge insets for a specific toggle.
 * @param edgeInsets The edge insets to set.
 * @param toggleIndex The index.
 **/
- (void)setImageEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex;

/**
 * Sets the image edge insets for all toggles.
 * @param edgeInsets The edge insets to set.
 **/
- (void)setImageEdgeInsets:(UIEdgeInsets)edgeInsets UI_APPEARANCE_SELECTOR;

/**
 * Returns the button at given index.
 * @param toggleIndex The index.
 * @return The UIButton instance.
 * @discussion Use this method for a even more customized configuration of each button.
 **/
- (UIButton*)buttonForToggleAtIndex:(NSInteger)toggleIndex;

@end
