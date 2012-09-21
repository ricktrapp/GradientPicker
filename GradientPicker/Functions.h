//
//  Functions.h
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

#import <Foundation/Foundation.h>

void drawFilledRect(CGContextRef context, CGRect rect, UIColor *aColor);
void draw2ColorRGBAGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, Boolean extend);
void draw2ColorRGBARadialGadient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint, CGFloat startRadius, CGFloat endRadius, Boolean extend);

