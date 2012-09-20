//
//  ViewController.h
//  GradientPicker
//
//  Created by Richard Trapp on 9/18/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILColorPickerView.h"
#import "ControlView.h"
#import "LineStartView.h"
#import "LineEndView.h"

@interface ViewController : UIViewController <ILColorPickerViewDelegate, ControlViewDelegate, UIGestureRecognizerDelegate>  {
    ILColorPickerView *startColorPicker;
    ILColorPickerView *endColorPicker;
    ControlView *controlView;
    LineStartView *lineStartView;
    LineEndView *lineEndView;
    int numberOfColors;
    UITextView *textView;
    UIPanGestureRecognizer *controlPanGesture;
}
@property (strong, nonatomic)ILColorPickerView *startColorPicker;
@property (strong, nonatomic)ILColorPickerView *endColorPicker;
@property (strong, nonatomic)ControlView *controlView;
@property (strong, nonatomic)LineStartView *lineStartView;
@property (strong, nonatomic)LineEndView *lineEndView;
@property (nonatomic)int numberOfColors;
@property (strong, nonatomic)UITextView *textView;
@property (strong, nonatomic)UIPanGestureRecognizer *controlPanGesture;
@end
