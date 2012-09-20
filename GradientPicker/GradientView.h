//
//  GradientView.h
//  GCPpoc2
//
//  Created by Richard Trapp on 9/12/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView {
    UIColor *startColor;
    UIColor *endColor;
    CGPoint startPoint;
    CGPoint endPoint;
    Boolean typeSaysLinear;
    Boolean typeSaysExtend;
    CGFloat startRadius;
    CGFloat endRadius;
    int numberOfColors;
}
@property (strong, nonatomic)UIColor *startColor;
@property (strong, nonatomic)UIColor *endColor;
@property (nonatomic)CGPoint startPoint;
@property (nonatomic)CGPoint endPoint;
@property (nonatomic)Boolean typeSaysLinear;
@property (nonatomic)Boolean typeSaysExtend;
@property (nonatomic)CGFloat startRadius;
@property (nonatomic)CGFloat endRadius;
@property (nonatomic)int numberOfColors;
@end
