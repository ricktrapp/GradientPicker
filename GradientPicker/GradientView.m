//
//  GradientView.m
//  GCPpoc2
//
//  Created by Richard Trapp on 9/12/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "GradientView.h"
#import "Functions.h"

@implementation GradientView
@synthesize startColor;
@synthesize endColor;
@synthesize startPoint;
@synthesize endPoint;
@synthesize typeSaysLinear;
@synthesize typeSaysExtend;
@synthesize startRadius;
@synthesize endRadius;
@synthesize numberOfColors;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    drawFilledRect(context, rect, [UIColor whiteColor]);
    if (self.numberOfColors == 1) {
        drawFilledRect(context, rect, self.startColor);
    } else {
        if (self.typeSaysLinear) {
            draw2ColorRGBARadialGadient(context, rect, self.startColor.CGColor, self.endColor.CGColor, self.startPoint, self.endPoint, self.startRadius, self.endRadius, typeSaysExtend);
        } else {
            draw2ColorRGBAGadient(context, rect, self.startColor.CGColor, self.endColor.CGColor, self.startPoint, self.endPoint, typeSaysExtend);
        }
        CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
        CGContextSetLineWidth(context, 2);
        CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
