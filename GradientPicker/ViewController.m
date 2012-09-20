//
//  ViewController.m
//  GradientPicker
//
//  Created by Richard Trapp on 9/18/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "ViewController.h"
#import "GradientView.h"
#include "TargetConditionals.h"
#import "LineStartView.h"
#import "LineEndView.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize startColorPicker;
@synthesize endColorPicker;
@synthesize controlView;
@synthesize lineStartView;
@synthesize lineEndView;
@synthesize numberOfColors;
@synthesize textView;
@synthesize controlPanGesture;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfColors = 1;
    ((GradientView *)self.view).numberOfColors = self.numberOfColors;
    
    CGRect startFrame = CGRectMake(30, 260, 340, 450);
    self.startColorPicker = [self setupApicker:startFrame withTitle:@"Start"];
    ((GradientView *)self.view).startColor = self.startColorPicker.color;
    
    CGRect endFrame = CGRectMake(400, 260, 340, 450);
    self.endColorPicker = [self setupApicker:endFrame withTitle:@"End"];
    ((GradientView *)self.view).endColor = self.endColorPicker.color;
    self.endColorPicker.superview.hidden = YES;
    
    CGRect controlFrame = CGRectMake(160, 5, 450, 175);
    self.controlView = [[ControlView alloc] initWithFrame:controlFrame];
    self.controlView.delegate = self;
    self.controlView.layer.cornerRadius = kCornerRadius;
    self.controlView.layer.masksToBounds = YES;
    ((GradientView *)self.view).typeSaysLinear = NO;
    ((GradientView *)self.view).typeSaysExtend = NO;
    ((GradientView *)self.view).startRadius = kStartRadius;
    self.controlView.startSlider.value = kStartRadius;
    self.controlView.startRadius = kStartRadius;
    ((GradientView *)self.view).endRadius = kEndRadius;
    self.controlView.endSlider.value = kEndRadius;
    self.controlView.endRadius = kEndRadius;
    self.controlView.numberOfColors = self.numberOfColors;
    [self.view addSubview:self.controlView];
    self.controlPanGesture = [[UIPanGestureRecognizer alloc]
                              initWithTarget:self action:@selector(handlePanGesture:)];
    self.controlPanGesture.delegate = self;
    [self.controlView addGestureRecognizer:self.controlPanGesture];
    self.controlView.startView = self.startColorPicker;
    self.controlView.endView = self.endColorPicker;
    
    CGPoint lineStartPoint = CGPointMake(20, 200);
    CGRect lineStartRect = CGRectMake(lineStartPoint.x, lineStartPoint.y-9, 18, 18);
    self.lineStartView = [[LineStartView alloc] initWithFrame:lineStartRect];
//    self.lineStartView.backgroundColor = [UIColor clearColor];
    self.lineStartView.hidden = YES;
    [self.view addSubview:self.lineStartView];
    UIPanGestureRecognizer *startPanGesture = [[UIPanGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handlePanGesture:)];
    startPanGesture.delegate = self;
    [self.lineStartView addGestureRecognizer:startPanGesture];
    lineStartPoint.x += 4;
    ((GradientView *)self.view).startPoint = lineStartPoint;
    self.controlView.startPoint = lineStartPoint;
    
    CGPoint lineEndPoint = CGPointMake(740, 200);
    CGRect lineEndRect = CGRectMake(lineEndPoint.x, lineEndPoint.y-9, 18, 18);
    self.lineEndView = [[LineEndView alloc] initWithFrame:lineEndRect];
    [self.view addSubview:self.lineEndView];
    self.lineEndView.hidden = YES;
    UIPanGestureRecognizer *endPanGesture = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handlePanGesture:)];
    endPanGesture.delegate = self;
    [self.lineEndView addGestureRecognizer:endPanGesture];
    lineEndPoint.x += 4;
    ((GradientView *)self.view).endPoint = lineEndPoint;
    self.controlView.endPoint = lineEndPoint;
    
    CGRect textFrame = CGRectMake(85, 85, 440, 110);
    self.textView = [[UITextView alloc] initWithFrame:textFrame];
    self.textView.layer.cornerRadius = kCornerRadius;
    self.textView.layer.masksToBounds = YES;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = [UIColor blackColor];
    self.textView.hidden = YES;
    [self.view addSubview:self.textView];
    self.controlView.textLabel = self.textView;
    
    
    [self.view setNeedsDisplay];
}

- (ILColorPickerView *)setupApicker:(CGRect)rect withTitle:(NSString *)title {
    [super viewDidLoad];
    UIView *outerView = [[UIView alloc] initWithFrame:rect];
    outerView.layer.cornerRadius = kCornerRadius;
    outerView.layer.masksToBounds = YES;
    outerView.backgroundColor = [UIColor whiteColor];
    if ([title isEqualToString:@"Start"]) {
        CGRect lineStartRect = CGRectMake(10, 22, 8, 8);
        LineStartView *lsv = [[LineStartView alloc] initWithFrame:lineStartRect];
        [outerView addSubview:lsv];
    } else {
        CGRect lineEndRect = CGRectMake(10, 22, 8, 8);
        LineEndView *lev = [[LineEndView alloc] initWithFrame:lineEndRect];
        [outerView addSubview:lev];
    }
    CGRect labelFrame = CGRectMake(20, 10, 280, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = [NSString stringWithFormat:@"%@ Color", title];
    [outerView addSubview:label];
    CGRect frame = CGRectMake(10, 40, 320, 410);
	ILColorPickerView *cpv = [[ILColorPickerView alloc] initWithFrame:frame];
    cpv.delegate = self;
    [outerView addSubview:cpv];
    [self.view addSubview:outerView];
    UIColor *c=[UIColor colorWithRed:(arc4random()%100)/100.0f
                               green:(arc4random()%100)/100.0f
                                blue:(arc4random()%100)/100.0f
                               alpha:1.0];
    cpv.color = c;
    self.view.backgroundColor=c;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [outerView addGestureRecognizer:panGesture];
    return cpv;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *thisView = gestureRecognizer.view;
    if (thisView == self.lineStartView || thisView == self.lineEndView) {
        return YES;
    }
    CGPoint touchPoint = [touch locationInView:thisView];
    if (touchPoint.y > 30) {
        return NO;
    }
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if (recognizer.view == self.lineStartView) {
        ((GradientView *)self.view).startPoint = recognizer.view.center;
        self.controlView.startPoint = recognizer.view.center;
        [self.view setNeedsDisplay];
    }
    if (recognizer.view == self.lineEndView) {
        ((GradientView *)self.view).endPoint = recognizer.view.center;
        self.controlView.endPoint = recognizer.view.center;
        [self.view setNeedsDisplay];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - ControlViewDelegate
-(void)typeChanged:(Boolean)typeSaysLinear {
    ((GradientView *)self.view).typeSaysLinear = typeSaysLinear;
    [self.view setNeedsDisplay];
}

-(void)extendChanged:(Boolean)typeSaysExtend {
    ((GradientView *)self.view).typeSaysExtend = typeSaysExtend;
    [self.view setNeedsDisplay];
}

-(void)startSliderChanged:(CGFloat)startValue {
    ((GradientView *)self.view).startRadius = startValue;
    [self.view setNeedsDisplay];
}

-(void)endSliderChanged:(CGFloat)endValue {
    ((GradientView *)self.view).endRadius = endValue;
    [self.view setNeedsDisplay];
}

-(void)secondColorAdded {
    self.numberOfColors = 2;
    ((GradientView *)self.view).numberOfColors = self.numberOfColors;
    self.endColorPicker.superview.hidden = NO;
    self.lineStartView.hidden = NO;
    self.lineEndView.hidden = NO;
    [self.view setNeedsDisplay];
}

#pragma mark - ILColorPickerDelegate

-(void)colorPicked:(UIColor *)color forPicker:(ILColorPickerView *)picker
{
    if (picker == self.endColorPicker) {
        ((GradientView *)self.view).endColor = color;
    }
    if (picker == self.startColorPicker) {
        ((GradientView *)self.view).startColor = color;
    }
    [self.view setNeedsDisplay];
}

@end
