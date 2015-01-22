//
//  JBAudioPlayerView.m
//  SpikaEnterprise
//
//  Created by Josip Bernat on 1/19/15.
//  Copyright (c) 2015 Clover-Studio. All rights reserved.
//

#import "JBAudioPlayerView.h"
#import "PureLayout.h"

@interface JBAudioPlayerView ()

@end

@implementation JBAudioPlayerView

#pragma mark - Memory Management

- (void)dealloc {

    [_timeLabel removeObserver:self
                    forKeyPath:@"font"];
    
    [_timeLabel removeObserver:self
                    forKeyPath:@"text"];
}

#pragma mark - Initialization

- (instancetype)init {

    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

#pragma mark - View Setup

- (void)setupView {
    
    self.useAutoLayout = YES;
    
    //Control button
    self.playButtonImage = [UIImage imageNamed:@"play_button"];
    self.pauseButtonImage = [UIImage imageNamed:@"pause_button"];
    self.controlButtonInsets = UIEdgeInsetsMake(0.0f, 8.0f, 0.0f, 0.0f);
    
    self->_controlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _controlButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_controlButton setImage:self.playButtonImage forState:UIControlStateNormal];
    [_controlButton addTarget:self
                       action:@selector(onControl:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_controlButton];
    
    [self __updateControlButtonConstraints:_controlButton callUpdate:YES];
    
    // Time Label
    self.timeLabelInsets = UIEdgeInsetsMake(0.0f, 8.0f, 0.0f, 8.0f);
    
    self->_timeLabel = [[UILabel alloc] initForAutoLayout];
    _timeLabel.font = [UIFont systemFontOfSize:14.0f];
    _timeLabel.textColor = [UIColor blackColor];
    [self addSubview:_timeLabel];
    
    [_timeLabel addObserver:self
                 forKeyPath:@"font"
                    options:0
                    context:NULL];
    
    [self __updateTimeLabelConstraints:_timeLabel callUpdate:YES];

    // Progress View
    self.sliderViewInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 8.0f);
    
    self->_sliderView = [[UISlider alloc] initForAutoLayout];
    _sliderView.minimumTrackTintColor = [UIColor whiteColor];
    _sliderView.maximumTrackTintColor = [UIColor whiteColor];
    _sliderView.thumbTintColor = [UIColor blueColor];
    
    [_sliderView addTarget:self
                    action:@selector(onSlider:)
          forControlEvents:UIControlEventValueChanged];
    
    [_sliderView addTarget:self
                    action:@selector(onSliderDidEndDragging:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_sliderView];

    [self __updateSliderViewConstraints:_sliderView callUpdate:YES];
    
    [_timeLabel addObserver:self
                 forKeyPath:@"text"
                    options:0
                    context:NULL];
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    if (!self.useAutoLayout) {
        
        _controlButton.frame = CGRectMake((NSInteger)_controlButtonInsets.left,
                                          (NSInteger)(CGRectGetHeight(self.frame) / 2 - self.playButtonImage.size.height / 2),
                                          ceilf(self.playButtonImage.size.width),
                                          ceilf(self.playButtonImage.size.height));
        
        CGSize size = [_timeLabel sizeThatFits:CGSizeMake(100, 40)];
        _timeLabel.frame = CGRectMake(CGRectGetMaxX(_controlButton.frame) + _timeLabelInsets.right,
                                      (NSInteger)(CGRectGetHeight(self.frame) / 2 - size.height / 2),
                                      ceilf(size.width),
                                      ceilf(size.height));
        
        _sliderView.frame = CGRectMake((NSInteger)(CGRectGetMaxX(_timeLabel.frame) + _timeLabelInsets.right),
                                       (NSInteger)(CGRectGetHeight(self.frame) / 2 - 30 / 2),
                                       ceilf(CGRectGetWidth(self.frame) - (CGRectGetMaxX(_timeLabel.frame) + _timeLabelInsets.right) - _sliderViewInsets.right),
                                       30.0f);
    }
}

#pragma mark - Layout

- (void)__removeConstraintsOnView:(UIView *)view {

    if (view.superview) {
        
        UIView *superView = view.superview;
        [view removeFromSuperview];
        [superView addSubview:view];
    }
}

- (void)__updateControlButtonConstraints:(UIView *)view callUpdate:(BOOL)update {
    
    if (!self.useAutoLayout) { return; }
    
    if (!view || !view.superview) {
        return;
    }
    
    [self __removeConstraintsOnView:view];

    [view autoPinEdge:ALEdgeLeft
               toEdge:ALEdgeLeft
               ofView:view.superview
           withOffset:_controlButtonInsets.left];
    
    [view autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view.superview];
    
    [view autoSetDimension:ALDimensionWidth
                    toSize:self.playButtonImage.size.width];
    
    [view autoSetDimension:ALDimensionHeight
                    toSize:self.playButtonImage.size.height];
    
    if (update) {
        [self didUpdateControlButtonConstraints];
    }
}

- (void)__updateTimeLabelConstraints:(UIView *)view callUpdate:(BOOL)update {
    
    if (!self.useAutoLayout) { return; }
    
    if (!view || !view.superview) {
        return;
    }
    
    [self __removeConstraintsOnView:view];
    
    [view autoPinEdge:ALEdgeLeft
               toEdge:ALEdgeRight
               ofView:_controlButton
           withOffset:_controlButtonInsets.right + _timeLabelInsets.left];
    
    [view autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view.superview];

    [view autoSetDimension:ALDimensionWidth
                    toSize:0.0f
                  relation:NSLayoutRelationGreaterThanOrEqual];
    
    [view autoSetDimension:ALDimensionHeight
                    toSize:0.0f
                  relation:NSLayoutRelationGreaterThanOrEqual];
    
    if (update) {
        [self didUpdateTimeLabelConstraints];
    }
}

- (void)__updateSliderViewConstraints:(UIView *)view callUpdate:(BOOL)update {
    
    if (!self.useAutoLayout) { return; }
    
    if (!view || !view.superview) {
        return;
    }
    [self __removeConstraintsOnView:view];
    
    [view autoPinEdge:ALEdgeLeft
               toEdge:ALEdgeRight
               ofView:_timeLabel
           withOffset:_timeLabelInsets.right + _sliderViewInsets.left];
    
    [view autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view.superview];
    
    [view autoPinEdge:ALEdgeRight
               toEdge:ALEdgeRight
               ofView:view.superview
           withOffset:-_sliderViewInsets.right];
    
    [view autoSetDimension:ALDimensionHeight
                    toSize:30.0f];
    
    if (update) {
        [self didUpdateSliderViewConstraints];
    }
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {

    if ([keyPath isEqualToString:@"font"] && [object isEqual:_timeLabel]) {
        [self __updateTimeLabelConstraints:_timeLabel callUpdate:YES];
    }
    else if ([keyPath isEqualToString:@"text"]) {
        [self setNeedsLayout];
    }
}

#pragma mark - Setters

- (void)setPlayButtonImage:(UIImage *)playButtonImage {

    _playButtonImage = playButtonImage;
    
    [self __updateControlButtonConstraints:_controlButton callUpdate:YES];
}

- (void)setSliderViewValue:(CGFloat)sliderViewValue {

    if (_sliderView.isTracking) {
        return;
    }
    _sliderView.value = sliderViewValue;
}

- (void)setControlButtonInsets:(UIEdgeInsets)controlButtonInsets {

    _controlButtonInsets = controlButtonInsets;
    [self __updateControlButtonConstraints:_controlButton callUpdate:YES];
}

- (void)setTimeLabelInsets:(UIEdgeInsets)timeLabelInsets {

    _timeLabelInsets = timeLabelInsets;
    [self __updateTimeLabelConstraints:_timeLabel callUpdate:YES];
}

- (void)setSliderViewInsets:(UIEdgeInsets)sliderViewInsets {

    _sliderViewInsets = sliderViewInsets;
    [self __updateSliderViewConstraints:_sliderView callUpdate:YES];
}

- (void)setPlaying:(BOOL)playing {

    _playing = playing;
    
    if (playing) {
        [self.controlButton setImage:self.pauseButtonImage forState:UIControlStateNormal];
    }
    else {
        [self.controlButton setImage:self.playButtonImage forState:UIControlStateNormal];
    }
}

- (void)setUseAutoLayout:(BOOL)useAutoLayout {

    _useAutoLayout = useAutoLayout;
    
    if (!useAutoLayout) {
        
        [self __removeConstraintsOnView:_controlButton];
        [self __removeConstraintsOnView:_timeLabel];
        [self __removeConstraintsOnView:_sliderView];
        
        [self setNeedsLayout];
    }
    else {
    
        [self __updateControlButtonConstraints:_controlButton callUpdate:YES];
        [self __updateTimeLabelConstraints:_timeLabel callUpdate:YES];
        [self __updateSliderViewConstraints:_sliderView callUpdate:YES];
    }
}

#pragma mark - Button Selectors

- (void)onControl:(id)sender {

    if ([(NSObject *)_delegate respondsToSelector:@selector(audioPlayerView:didSelectControlButton:)]) {
        [_delegate audioPlayerView:self didSelectControlButton:_controlButton];
    }
}

#pragma mark - Slider Selector

- (void)onSlider:(id)sender {

    if ([(NSObject *)_delegate respondsToSelector:@selector(audioPlayerView:didDragSlider:)]) {
        [_delegate audioPlayerView:self didDragSlider:_sliderView];
    }
}

- (void)onSliderDidEndDragging:(id)sender {

    if ([(NSObject *)_delegate respondsToSelector:@selector(audioPlayerView:didEndDragging:)]) {
        [_delegate audioPlayerView:self didEndDragging:_sliderView];
    }
}

@end

@implementation JBAudioPlayerView (Layout)

#pragma mark - Adding Constraints

- (void)updateControlButtonViewConstraints:(UIView *)view {

    [self __updateControlButtonConstraints:view callUpdate:NO];
}

- (void)updateTimeLabelViewConstraints:(UIView *)view {

    [self __updateTimeLabelConstraints:view callUpdate:NO];
}

- (void)updateSliderViewConstraints:(UIView *)view {

    [self __updateSliderViewConstraints:view callUpdate:NO];
}

#pragma mark - Constraint Update

- (void)didUpdateControlButtonConstraints {
    
}


- (void)didUpdateTimeLabelConstraints {
    
}


- (void)didUpdateSliderViewConstraints {
    
}

@end
