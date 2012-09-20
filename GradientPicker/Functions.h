//
//  Functions.h
//  WhenWhereWhat
//
//  Created by Richard Trapp on 9/11/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//

#import <Foundation/Foundation.h>

void drawFilledRect(CGContextRef context, CGRect rect, UIColor *aColor);
void draw2ColorRGBAGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, Boolean extend);
void draw2ColorRGBARadialGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, CGFloat startRadius, CGFloat endRadius, Boolean extend);

