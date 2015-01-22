//
//  JBAudioPlayerView.h
//  SpikaEnterprise
//
//  Created by Josip Bernat on 1/19/15.
//  Copyright (c) 2015 Clover-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBAudioPlayerView;

@protocol JBAudioPlayerViewDelegate <NSObject>

- (void)audioPlayerView:(JBAudioPlayerView *)audioPlayerView didDragSlider:(UISlider *)slider;

- (void)audioPlayerView:(JBAudioPlayerView *)audioPlayerView didEndDragging:(UISlider *)slider;

- (void)audioPlayerView:(JBAudioPlayerView *)audioPlayerView didSelectControlButton:(UIButton *)button;

@end

@interface JBAudioPlayerView : UIView

@property (weak, nonatomic) id<JBAudioPlayerViewDelegate> delegate;
@property (readwrite, nonatomic) BOOL useAutoLayout;    // Defult is YES. Override in your subclass in order to disable it.

@property (strong, nonatomic) UIImage *playButtonImage;
@property (strong, nonatomic) UIImage *pauseButtonImage;
@property (readwrite, nonatomic, getter=isPlaying) BOOL playing;    // Changes control button image.
@property (strong, nonatomic, readonly) UIButton *controlButton;
@property (readwrite, nonatomic) UIEdgeInsets controlButtonInsets; // Default is 0.0f, 8.0f, 0.0f, 0.0f

@property (strong, nonatomic, readonly) UILabel *timeLabel;
@property (readwrite, nonatomic) UIEdgeInsets timeLabelInsets; // Default is 0.0f, 8.0f, 0.0f, 8.0f

@property (strong, nonatomic, readonly) UISlider *sliderView;
@property (readwrite, nonatomic) UIEdgeInsets sliderViewInsets; // Default is 0.0f, 0.0f, 0.0f, 8.0f
@property (readwrite, nonatomic) CGFloat sliderViewValue;

#pragma mark - View Setup
/**
 *  Called from view init, initWith.. methods. If you override this method you must call super.
 */
- (void)setupView;


@end

@interface JBAudioPlayerView (Layout)

#pragma mark - Adding Constraints
/**
 *  Updates constraint for view which is in place of control button. Does not call didUpdateControlButtonConstraints.
 *
 *  @param view View on which we want to update constraints.
 */
- (void)updateControlButtonViewConstraints:(UIView *)view;

/**
 *  Updates constraint for view which is in place of time label. Does not call didUpdateTimeLabelConstraints.
 *
 *  @param view View on which we want to update constraints.
 */
- (void)updateTimeLabelViewConstraints:(UIView *)view;

/**
 *  Updates constraint for view which is in place of slider view. Does not call didUpdateSliderViewConstraints.
 *
 *  @param view View on which we want to update constraints.
 */
- (void)updateSliderViewConstraints:(UIView *)view;

#pragma mark - Constraint Update
/**
 *  Called after control button constraints are updated. Make any updates if needed to control button subviews added in your subclass.
 */
- (void)didUpdateControlButtonConstraints;

/**
 *  Called after time label constraints are updated. Make any updates if needed to time label subviews added in your subclass.
 */
- (void)didUpdateTimeLabelConstraints;

/**
 *  Called after slider view constraints are updated. Make any updates if needed to slider view subviews added in your subclass.
 */
- (void)didUpdateSliderViewConstraints;

@end
