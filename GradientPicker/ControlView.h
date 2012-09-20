//
//  ControlView.h
//  GCPpoc2
//
//  Created by Richard Trapp on 9/13/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILColorPickerView.h"

@protocol ControlViewDelegate

-(void)typeChanged:(Boolean)typeSaysLinear;
-(void)extendChanged:(Boolean)typeSaysExtend;
-(void)startSliderChanged:(CGFloat)startValue;
-(void)endSliderChanged:(CGFloat)endValue;
-(void)secondColorAdded;
@end


@interface ControlView : UIView {
    UIButton *startButton;
    UIButton *endButton;
    UIButton *generateButton;
    Boolean startButtonSaysHide;
    Boolean endButtonSaysHide;
    ILColorPickerView *startView;
    ILColorPickerView *endView;
    UITextView *textLabel;
    UIButton *typeButton;
    Boolean typeButtonSaysLinear;
    id<ControlViewDelegate> delegate;
    UIButton *extendButton;
    Boolean buttonSaysExtend;
    UISlider *startSlider;
    UISlider *endSlider;
    UILabel *startRadiusLabel;
    UILabel *endRadiusLabel;
    UIButton *hideButton;
    Boolean hideButtonSaysCollapse;
    CGPoint lastCenter;
    int numberOfColors;
    Boolean generateButtonSaysGenerate;
    CGPoint startPoint;
    CGPoint endPoint;
    CGFloat startRadius;
    CGFloat endRadius;
}
@property (strong, nonatomic)UIButton *startButton;
@property (strong, nonatomic)UIButton *endButton;
@property (strong, nonatomic)UIButton *generateButton;
@property (nonatomic) Boolean startButtonSaysHide;
@property (nonatomic) Boolean endButtonSaysHide;
@property (strong, nonatomic)ILColorPickerView *startView;
@property (strong, nonatomic)ILColorPickerView *endView;
@property (strong, nonatomic)UITextView *textLabel;
@property (strong, nonatomic)UIButton *typeButton;
@property (nonatomic) Boolean typeButtonSaysLinear;
@property (assign, nonatomic) id<ControlViewDelegate> delegate;
@property (strong, nonatomic)UIButton *extendButton;
@property (nonatomic) Boolean buttonSaysExtend;
@property (strong, nonatomic)UISlider *startSlider;
@property (strong, nonatomic)UISlider *endSlider;
@property (strong, nonatomic)UILabel *startRadiusLabel;
@property (strong, nonatomic)UILabel *endRadiusLabel;
@property (strong, nonatomic)UIButton *hideButton;
@property (nonatomic) Boolean hideButtonSaysCollapse;
@property (nonatomic)CGPoint lastCenter;
@property (nonatomic)int numberOfColors;
@property (nonatomic)Boolean generateButtonSaysGenerate;
@property (nonatomic)CGPoint startPoint;
@property (nonatomic)CGPoint endPoint;
@property (nonatomic)CGFloat startRadius;
@property (nonatomic)CGFloat endRadius;
@end
