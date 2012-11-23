//
//  LineStartView.m
//  GCPpoc2
//
//  Created by Richard Trapp on 9/14/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "LineStartView.h"
#import "Constants.h"

@implementation LineStartView

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
    
//    CGRect fillRect = rect;
//    CGContextAddRect(context, fillRect);
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillPath(context);

    CGFloat newX = (self.frame.size.width/2)-(kPointInnerDim/2);
    CGFloat newY = (self.frame.size.height/2)-(kPointInnerDim/2);
    CGRect smallSquare = CGRectMake(newX, newY, kPointInnerDim, kPointInnerDim);
    CGContextAddEllipseInRect(context, smallSquare);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 0.5);
    CGContextClosePath(context);
    CGContextSetShadow(context, CGSizeMake(1, 1), 4);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
