//
//  CTView.m
//  TestCoreText
//
//  Created by ZhaoNing on 16/7/14.
//  Copyright © 2016年 ZhaoNing. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>
@implementation CTView


- (void)drawRect:(CGRect)rect {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ref, CGAffineTransformIdentity);
    CGContextTranslateCTM(ref, 0, self.bounds.size.height);
    CGContextScaleCTM(ref, 1.0, -1.0);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Jack_Rose"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, NULL);
    CTFrameDraw(frame, ref);
    CFRelease(framesetter);
    CFRelease(path);
    CFRelease(frame);
}


@end
