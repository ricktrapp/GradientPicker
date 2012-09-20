//
//  ControlView.m
//  GCPpoc2
//
//  Created by Richard Trapp on 9/13/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "ControlView.h"
#import "ViewController.h"
#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@implementation ControlView
@synthesize startButton;
@synthesize startButtonSaysHide;
@synthesize endButton;
@synthesize endButtonSaysHide;
@synthesize startView;
@synthesize endView;
@synthesize generateButton;
@synthesize textLabel;
@synthesize typeButton;
@synthesize typeButtonSaysLinear;
@synthesize extendButton;
@synthesize buttonSaysExtend;
@synthesize startSlider;
@synthesize endSlider;
@synthesize startRadiusLabel;
@synthesize endRadiusLabel;
@synthesize hideButton;
@synthesize hideButtonSaysCollapse;
@synthesize lastCenter;
@synthesize numberOfColors;
@synthesize generateButtonSaysGenerate;
@synthesize startPoint;
@synthesize endPoint;
@synthesize startRadius;
@synthesize endRadius;

static NSString *kStartHideTitle = @"Hide Start Color";
static NSString *kStartShowTitle = @"Show Start Color";
static NSString *kEndHideTitle = @"Hide End Color";
static NSString *kEndShowTitle = @"Show End Color";
static NSString *kTypeLinearTitle = @"Linear";
static NSString *kTypeRadialTitle = @"Radial";
static NSString *kToExtendTitle = @"Extend";
static NSString *kNotToExtendTitle = @"No Extend";
static NSString *kCollapse = @"-";
static NSString *kExpand = @"+";
static NSString *kGenerate = @"Generate";
static NSString *kHideGenerate = @"Hide Generated";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        CGRect labelFrame = CGRectMake(160, 5, 140, 20);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
        titleLabel.layer.cornerRadius = kCornerRadius;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.text = @"Control";
        [self addSubview:titleLabel];
        
        CGRect hideFrame = CGRectMake(410, 5, 25, 20);
        self.hideButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.hideButton.frame = hideFrame;
        [self.hideButton setTitle:kCollapse forState:UIControlStateNormal];
        self.hideButtonSaysCollapse = YES;
        self.hideButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.hideButton addTarget:self action:@selector(toggleHideButton:)  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hideButton];
        
        CGRect startFrame = CGRectMake(5, 35, 90, 40);
        self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.startButton.frame = startFrame;
        [self.startButton setTitle:kStartHideTitle forState:UIControlStateNormal];
        self.startButtonSaysHide = YES;
        self.startButton.titleLabel.numberOfLines = 2;
        self.startButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self.startButton addTarget:self action:@selector(toggleStartButton:)  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.startButton];
        
        CGRect endFrame = CGRectMake(100, 35, 90, 40);
        self.endButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.endButton.frame = endFrame;
        [self.endButton setTitle:@"Add 2nd Color" forState:UIControlStateNormal];
        self.endButtonSaysHide = YES;
        self.endButton.titleLabel.numberOfLines = 2;
        self.endButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self.endButton addTarget:self action:@selector(toggleEndButton:)  forControlEvents:UIControlEventTouchUpInside];
        self.endButton.enabled = YES;
        [self addSubview:self.endButton];
        
        CGRect typeFrame = CGRectMake(195, 35, 80, 40);
        self.typeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.typeButton.frame = typeFrame;
        [self.typeButton setTitle:kTypeRadialTitle forState:UIControlStateNormal];
        self.typeButtonSaysLinear = NO;
        [self.typeButton addTarget:self action:@selector(typeButton:)  forControlEvents:UIControlEventTouchUpInside];
        self.typeButton.enabled = NO;
        self.typeButton.hidden = YES;
        [self addSubview:self.typeButton];
        
        CGRect extendFrame = CGRectMake(280, 35, 80, 40);
        self.extendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.extendButton.frame = extendFrame;
        [self.extendButton setTitle:kNotToExtendTitle forState:UIControlStateNormal];
        self.buttonSaysExtend = NO;
        [self.extendButton addTarget:self action:@selector(extendButton:)  forControlEvents:UIControlEventTouchUpInside];
        self.extendButton.enabled = NO;
        self.extendButton.hidden = YES;
        [self addSubview:self.extendButton];
        
        CGRect generateFrame = CGRectMake(365, 35, 80, 40);
        self.generateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.generateButton.frame = generateFrame;
        [self.generateButton setTitle:kGenerate forState:UIControlStateNormal];
        self.generateButton.titleLabel.numberOfLines = 2;
        self.generateButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.generateButton.enabled = YES;
        self.generateButtonSaysGenerate = YES;
        [self.generateButton addTarget:self action:@selector(generateButton:)  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.generateButton];
        
        CGRect startRadiusLabelFrame = CGRectMake(5, 85, 110, 30);
        self.startRadiusLabel = [[UILabel alloc] initWithFrame:startRadiusLabelFrame];
        self.startRadiusLabel.layer.cornerRadius = kCornerRadius;
        self.startRadiusLabel.layer.masksToBounds = YES;
        self.startRadiusLabel.text = @"Start Radius";
        self.startRadiusLabel.enabled = NO;
        self.startRadiusLabel.hidden = YES;
        [self addSubview:self.startRadiusLabel];
        CGRect startRadiusFrame = CGRectMake(120, 85, 325, 30);
        self.startSlider = [[UISlider alloc] initWithFrame:startRadiusFrame];
        self.startSlider.minimumValue = kSliderMin;
        self.startSlider.maximumValue = kSliderMax;
        [self.startSlider addTarget:self action:@selector(startSlider:)  forControlEvents:UIControlEventValueChanged];
        self.startSlider.enabled = NO;
        self.startSlider.hidden = YES;
        [self addSubview:startSlider];
        
        CGRect endRadiusLabelFrame = CGRectMake(5, 130, 110, 30);
        self.endRadiusLabel = [[UILabel alloc] initWithFrame:endRadiusLabelFrame];
        self.endRadiusLabel.layer.cornerRadius = kCornerRadius;
        self.endRadiusLabel.layer.masksToBounds = YES;
        self.endRadiusLabel.text = @"End Radius";
        self.endRadiusLabel.enabled = NO;
        self.endRadiusLabel.hidden = YES;
        [self addSubview:self.endRadiusLabel];
        CGRect endRadiusFrame = CGRectMake(120, 130, 325, 30);
        self.endSlider = [[UISlider alloc] initWithFrame:endRadiusFrame];
        self.endSlider.minimumValue = kSliderMin;
        self.endSlider.maximumValue = kSliderMax;
        [self.endSlider addTarget:self action:@selector(endSlider:)  forControlEvents:UIControlEventValueChanged];
        self.endSlider.enabled = NO;
        self.endSlider.hidden = YES;
        [self addSubview:endSlider];
    }
    return self;
}

- (void)toggleStartButton:(id)sender {
    if (self.startButtonSaysHide) {
        self.startView.superview.hidden = YES;
        [((UIButton *)sender) setTitle:kStartShowTitle forState:UIControlStateNormal];
    } else {
        self.startView.superview.hidden = NO;
        [((UIButton *)sender) setTitle:kStartHideTitle forState:UIControlStateNormal];
    }
    self.startButtonSaysHide = !self.startButtonSaysHide;
}

- (void)toggleEndButton:(id)sender {
    if (self.numberOfColors > 1) {
        if (self.endButtonSaysHide) {
            self.endView.superview.hidden = YES;
            [((UIButton *)sender) setTitle:kEndShowTitle forState:UIControlStateNormal];
        } else {
            self.endView.superview.hidden = NO;
            [((UIButton *)sender) setTitle:kEndHideTitle forState:UIControlStateNormal];
        }
        self.endButtonSaysHide = !self.endButtonSaysHide;
    } else {
        self.numberOfColors = 2;
        [((UIButton *)sender) setTitle:kEndHideTitle forState:UIControlStateNormal];
        [_delegate secondColorAdded];
        self.typeButton.enabled = YES;
        self.typeButton.hidden = NO;
        self.extendButton.enabled = YES;
        self.extendButton.hidden = NO;
        self.startRadiusLabel.hidden = NO;
        self.startSlider.hidden = NO;
        self.endRadiusLabel.hidden = NO;
        self.endSlider.hidden = NO;
    }
}

- (void)toggleHideButton:(id)sender {
    if (self.hideButtonSaysCollapse) {
        CGPoint aCenter = CGPointMake(self.frame.origin.x+(self.bounds.size.width/2), self.frame.origin.y+15);
        CGRect existingFrame = self.bounds;
//        CGFloat existingHeight = existingFrame.size.height;
//        existingHeight = 30;
        existingFrame.size.height = 30;
        self.bounds = existingFrame;
        self.center = aCenter;
        [((UIButton *)sender) setTitle:kExpand forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        self.endButton.hidden = YES;
        self.typeButton.hidden = YES;
        self.extendButton.hidden = YES;
        self.generateButton.hidden = YES;
        self.startRadiusLabel.hidden = YES;
        self.startSlider.hidden = YES;
        self.endRadiusLabel.hidden = YES;
        self.endSlider.hidden = YES;
    } else {
        CGPoint aCenter = CGPointMake(self.frame.origin.x+(self.bounds.size.width/2), self.frame.origin.y+(175/2));
        CGRect existingFrame = self.bounds;
//        CGFloat existingHeight = existingFrame.size.height;
//        existingHeight = 175;
        existingFrame.size.height = 175;
        self.bounds = existingFrame;
        self.center = aCenter;
        [((UIButton *)sender) setTitle:kCollapse forState:UIControlStateNormal];
        self.startButton.hidden = NO;
        self.generateButton.hidden = NO;
        self.endButton.hidden = NO;
        if (self.numberOfColors > 1) {
            self.typeButton.hidden = NO;
            self.extendButton.hidden = NO;
            self.startRadiusLabel.hidden = NO;
            self.startSlider.hidden = NO;
            self.endRadiusLabel.hidden = NO;
            self.endSlider.hidden = NO;
        }
    }
    self.hideButtonSaysCollapse = !self.hideButtonSaysCollapse;
}

- (void)generateButton:(id)sender {
    if (self.generateButtonSaysGenerate) {
        self.textLabel.hidden = NO;
        CGFloat sr, sg, sb, sa;
        CGFloat er, eg, eb, ea;
        UIColor *startColor = self.startView.color;
        [startColor getRed:&sr green:&sg blue:&sb alpha:&sa];
        NSString *extend = @"YES";
        if (self.buttonSaysExtend) {
            extend = @"NO";
        }
        if (self.numberOfColors == 1) {
            self.textLabel.text = [NSString stringWithFormat:@"UIColor *aColor = [UIColor colorWithRed:%g green:%g blue:%g alpha:%g];\ndrawFilledRect(context, rect, aColor);\n", sr, sg, sb, sa];
        } else {
            UIColor *endColor = self.endView.color;
            [endColor getRed:&er green:&eg blue:&eb alpha:&ea];
            if (self.typeButtonSaysLinear) {
                self.textLabel.text = [NSString stringWithFormat:@"UIColor *startColor = [UIColor colorWithRed:%g green:%g blue:%g alpha:%g];\nUIColor *endColor = [UIColor colorWithRed:%g green:%g blue:%g alpha:%g];\nCGPoint startPoint = CGPointMake(%.0f, %.0f);\nCGPoint endPoint = CGPointMake(%.0f, %.0f);\ndraw2ColorRGBARadialGadient(context, rect, startColor.CGColor, endColor.CGColor, startPoint, endPoint, %.0f, %.0f, %@);\n", sr, sg, sb, sa, er, eg, eb, ea, self.startPoint.x, self.startPoint.y, self.endPoint.x, self.endPoint.y, self.startRadius, self.endRadius, extend];
            } else {
                self.textLabel.text = [NSString stringWithFormat:@"UIColor *startColor = [UIColor colorWithRed:%g green:%g blue:%g alpha:%g];\nUIColor *endColor = [UIColor colorWithRed:%g green:%g blue:%g alpha:%g];\nCGPoint startPoint = CGPointMake(%.0f, %.0f);\nCGPoint endPoint = CGPointMake(%.0f, %.0f);\ndraw2ColorRGBAGadient(context, rect, startColor.CGColor, endColor.CGColor, startPoint, endPoint, %@);\n", sr, sg, sb, sa, er, eg, eb, ea, self.startPoint.x, self.startPoint.y, self.endPoint.x, self.endPoint.y, extend];
            }
        }
        [((UIButton *)sender) setTitle:kHideGenerate forState:UIControlStateNormal];
    } else {
        self.textLabel.hidden = YES;
        [((UIButton *)sender) setTitle:kGenerate forState:UIControlStateNormal];
    }
    self.generateButtonSaysGenerate = !self.generateButtonSaysGenerate;
}

- (void)typeButton:(id)sender {
    if (self.typeButtonSaysLinear) {
        [((UIButton *)sender) setTitle:kTypeRadialTitle forState:UIControlStateNormal];
        self.startSlider.enabled = NO;
        self.endSlider.enabled = NO;
        self.startRadiusLabel.enabled = NO;
        self.endRadiusLabel.enabled = NO;
    } else {
        [((UIButton *)sender) setTitle:kTypeLinearTitle forState:UIControlStateNormal];
        self.startSlider.enabled = YES;
        self.endSlider.enabled = YES;
        self.startRadiusLabel.enabled = YES;
        self.endRadiusLabel.enabled = YES;
    }
    self.typeButtonSaysLinear = !self.typeButtonSaysLinear;
    [_delegate typeChanged:self.typeButtonSaysLinear];
}

- (void)extendButton:(id)sender {
    if (self.buttonSaysExtend) {
        [((UIButton *)sender) setTitle:kNotToExtendTitle forState:UIControlStateNormal];
    } else {
        [((UIButton *)sender) setTitle:kToExtendTitle forState:UIControlStateNormal];
    }
    self.buttonSaysExtend = !self.buttonSaysExtend;
    [_delegate extendChanged:self.buttonSaysExtend];
}

- (void)startSlider:(id)sender {
    [_delegate startSliderChanged:[(UISlider *)sender value]];
    self.startRadius = [(UISlider *)sender value];
}

- (void)endSlider:(id)sender {
    [_delegate endSliderChanged:[(UISlider *)sender value]];
    self.endRadius = [(UISlider *)sender value];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
