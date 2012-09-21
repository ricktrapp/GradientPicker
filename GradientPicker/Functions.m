//
//  Functions.m
//
//  Created by Richard Trapp on 9/11/12.
//  Copyright (c) 2012 Richard Trapp. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Functions.h"

void drawFilledRect(CGContextRef context, CGRect rect, UIColor *aColor) {
    CGRect fillRect = rect;
    CGContextAddRect(context, fillRect);
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextFillPath(context);
}

void draw2ColorRGBAGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, Boolean extend) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    if (extend) {
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    } else {
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    }
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
void draw2ColorRGBARadialGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, CGFloat startRadius, CGFloat endRadius, Boolean extend) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    if (extend) {
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0);
    } else {
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    }
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
