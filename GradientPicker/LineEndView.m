//
//  LineEndView.m
//  GCPpoc2
//
//  Created by Richard Trapp on 9/14/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "LineEndView.h"
#import "Constants.h"

@implementation LineEndView

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
    
    
//    CGRect myRect = {{x1, y1, {x2 - x1, y2 - y1}};
    CGFloat newX = (self.frame.size.width/2)-(kPointInnerDim/2);
    CGFloat newY = (self.frame.size.height/2)-(kPointInnerDim/2);
    CGRect smallSquare = CGRectMake(newX, newY, kPointInnerDim, kPointInnerDim);
//        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    
//        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    
    
    
    
//    CGRect fillRect = rect;
//    CGContextAddRect(context, fillRect);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextFillPath(context);
    CGContextFillRect(context, smallSquare);
}

@end
