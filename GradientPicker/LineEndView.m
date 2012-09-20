//
//  LineEndView.m
//  GCPpoc2
//
//  Created by Richard Trapp on 9/14/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import "LineEndView.h"

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
    CGRect fillRect = rect;
    CGContextAddRect(context, fillRect);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);
}

@end
