//
//  MJMultiToggleControl.m
//
//  Created by Joan Martin on 23/01/14.
//  Copyright (c) 2014 MobileJazz. All rights reserved.
//

#import "MJMultiToggleControl.h"

NSInteger UIMultiToggleControlSelectionNone = -1;

@implementation MJMultiToggleControl
{
    NSArray *_toggles;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame toggleCount:0];
}

- (id)initWithFrame:(CGRect)frame toggleCount:(NSInteger)toggleCount
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _toggleCount = toggleCount;
        [self mj_doInit];
        [self mj_doInitToggles];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _toggleCount = 0;
        [self mj_doInit];
    }
    return self;
}

- (void)mj_doInit
{
    _toggleSeparation = 0.0f;
    _toggles = @[];
    _selectedToggle = UIMultiToggleControlSelectionNone;
    _allowsSelectionNone = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGSize toggleSize = CGSizeMake((bounds.size.width - _toggleSeparation*(_toggleCount - 1))/_toggleCount, bounds.size.height);
    
    for (NSInteger i=0; i<_toggleCount; ++i)
    {
        CGRect frame = CGRectZero;
        frame.origin.x = (toggleSize.width + _toggleSeparation) * i;
        frame.origin.y = 0.0f;
        frame.size.width = toggleSize.width;
        frame.size.height = toggleSize.height;
        
        UIButton *toggle = _toggles[i];
        toggle.frame = frame;
        
        if ([toggle imageForState:toggle.state])
        {
            // Finally, setting images above title in each button
            
            // the space between the image and text
            CGFloat spacing = 0.0;
            
            // lower the text and push it left so it appears centered
            //  below the image
            CGSize imageSize = toggle.imageView.frame.size;
            toggle.titleEdgeInsets = UIEdgeInsetsMake( 0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
            
            // raise the image and push it right so it appears centered
            //  above the text
            CGSize titleSize = toggle.titleLabel.frame.size;
            toggle.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        }
    }
}

#pragma mark Properties

- (void)setToggleCount:(NSInteger)toggleCount
{
    _toggleCount = toggleCount;
    
    [self mj_removeToggles];
    [self mj_doInitToggles];
}

- (void)setSelectedToggle:(NSInteger)selectedToggle
{
    if (_selectedToggle < -1 && selectedToggle >= _toggles.count)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"Invalid toggle index %ld in range [%ld,%ld]", (long)selectedToggle, (long)0, (long)_toggles.count]
                                     userInfo:nil];
    }
    
    [self willChangeValueForKey:@"selectedToggle"];
    _selectedToggle = selectedToggle;
    [self didChangeValueForKey:@"selectedToggle"];
    
    for (NSInteger i=0; i<_toggles.count; ++i)
    {
        UIButton *toggle = _toggles[i];
        toggle.selected = (i == selectedToggle);
    }
}

#pragma mark Pubic Methods

- (UIButton*)buttonForToggleAtIndex:(NSInteger)toggleIndex
{
    return _toggles[toggleIndex];
}

- (NSString*)titleForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle titleForState:state];
}

- (void)setTitle:(NSString*)string forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setTitle:string forState:state];
}

- (UIFont*)titleFontForToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    return toggle.titleLabel.font;
}

- (void)setTitleFont:(UIFont*)font forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    toggle.titleLabel.font = font;
}

- (void)setTitleFont:(UIFont*)font
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        toggle.titleLabel.font = font;
    }];
}

- (UIColor*)titleColorForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle titleColorForState:state];
}

- (void)setTitleColor:(UIColor*)color forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setTitleColor:color forState:state];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        [toggle setTitleColor:color forState:state];
    }];
}

- (UIImage*)imageForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex;
{
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle imageForState:state];
}

- (void)setImage:(UIImage*)image forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setImage:image forState:state];
}

- (UIImage*)backgroundImageForState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle backgroundImageForState:state];
}

- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state forToggleAtIndex:(NSInteger)toggleIndex
{
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setBackgroundImage:image forState:state];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        [toggle setBackgroundImage:image forState:state];
    }];
}

- (UIEdgeInsets)titleEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle titleEdgeInsets];
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setTitleEdgeInsets:edgeInsets];
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        [toggle setTitleEdgeInsets:edgeInsets];
    }];
}

- (UIEdgeInsets)contentEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle contentEdgeInsets];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setContentEdgeInsets:edgeInsets];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        [toggle setContentEdgeInsets:edgeInsets];
    }];
}

- (UIEdgeInsets)imageEdgeInsetsForToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    return [toggle imageEdgeInsets];
}

- (void)setImageEdgeInsets:(UIEdgeInsets)edgeInsets forToggleAtIndex:(NSInteger)toggleIndex {
    UIButton *toggle = _toggles[toggleIndex];
    [toggle setImageEdgeInsets:edgeInsets];
}

- (void)setImageEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [_toggles enumerateObjectsUsingBlock:^(UIButton *toggle, NSUInteger idx, BOOL *stop) {
        [toggle setImageEdgeInsets:edgeInsets];
    }];
}

#pragma mark Private Methods

- (void)mj_removeToggles
{
    [_toggles makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _toggles = nil;
}

- (void)mj_doInitToggles
{
    NSMutableArray *toggles = [NSMutableArray arrayWithCapacity:_toggleCount];
    
    for (int i=0; i<_toggleCount; ++i)
    {
        UIButton *toggle = [UIButton buttonWithType:UIButtonTypeCustom];
        toggle.tag = i;
        toggle.titleLabel.textAlignment = NSTextAlignmentCenter;
        toggle.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        toggle.titleLabel.numberOfLines = 0;
        
        [toggle addTarget:self action:@selector(mj_toggleAction:) forControlEvents:UIControlEventTouchUpInside];
        [toggles addObject:toggle];
        
        [self addSubview:toggle];
        
        [toggle setTitle:[NSString stringWithFormat:@"Toggle %d", i] forState:UIControlStateNormal];
    }
    
    _toggles = [toggles copy];
}

- (void)mj_toggleAction:(UIButton*)toggle
{
    if (toggle.selected && !_allowsSelectionNone)
        return;
    
    toggle.selected = !toggle.selected;
    
    for (UIButton *otherToggle in _toggles)
    {
        if (otherToggle != toggle)
            otherToggle.selected = !toggle.selected;
    }
    
    [self willChangeValueForKey:@"selectedToggle"];
    _selectedToggle = toggle.selected ? toggle.tag : UIMultiToggleControlSelectionNone;
    [self didChangeValueForKey:@"selectedToggle"];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
