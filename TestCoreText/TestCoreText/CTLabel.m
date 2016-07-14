//
//  CTLabel.m
//  TestCoreText
//
//  Created by ZhaoNing on 16/7/14.
//  Copyright © 2016年 ZhaoNing. All rights reserved.
//

#import "CTLabel.h"
#import <CoreText/CoreText.h>

static inline CGFloat FlushFactorForTextAlignment(NSTextAlignment textAlignment) {
    switch (textAlignment) {
        case NSTextAlignmentCenter:
            return 0.5f;
        case NSTextAlignmentRight:
            return 1.0f;
        case NSTextAlignmentLeft:
        default:
            return 0.0f;
    }
}

@interface CTLabel()
@property (nonatomic, strong) NSMutableArray *linkArray;
@end

@implementation CTLabel
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    if (![self needResponseTouchLabel:location]) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}
- (BOOL)needResponseTouchLabel:(CGPoint)point {
    CGPoint newPoint = [self convertPoint:point toView:self];
    NSUInteger curIndex = (NSUInteger)[self characterIndexAtPoint:newPoint];
    __block BOOL needResponse = NO;
    if ([self.text rangeOfString:_linkString].location == NSNotFound) {
        return NO;
    }else {
        NSRange range = [self.text rangeOfString:_linkString];
        if (NSLocationInRange(curIndex, range)) {
            NSLog(@"我点击了%@", _linkString);
            needResponse = YES;
        }
        if (needResponse) {
            return YES;
        }else {
            return NO;
        }
    }

}
- (CFIndex)characterIndexAtPoint:(CGPoint)p {
    CGRect bounds = self.bounds;
    if (!CGRectContainsPoint(bounds, p)) {
        return NSNotFound;
    }
    CGRect textRect = [self textRectForBounds:bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.size = CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
    CGRect pathRect = CGRectMake(textRect.origin.x, textRect.origin.y, textRect.size.width, textRect.size.height + 100000);
    if (!CGRectContainsPoint(textRect, p)) {
        return NSNotFound;
    }
    p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y);
    //p.x - 5 是因为x轴有5px左右的偏移误差
    //pathRect.size.height - p.y 由笛卡尔坐标系转化为iOS开发中用的的坐标系
    //   🔼  y               |------▶️ x
    //   |            ->     |
    //   |                   |
    //   |_______ ▶️ x      🔽  y
    p = CGPointMake(p.x - 5, pathRect.size.height - p.y);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, pathRect);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attributedText.length), path, NULL);
    
    if (frame == NULL) {
        CGPathRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    if (numberOfLines == 0) {
        CFRelease(frame);
        CGPathRelease(path);
        return NSNotFound;
    }
    
    CFIndex idx = NSNotFound;
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex ++) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
        CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);
        
        CGFloat flushFactor = FlushFactorForTextAlignment(self.textAlignment);
        CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flushFactor, textRect.size.width);
        lineOrigin.x = penOffset;
        
        if (p.y > yMax) {
            break;
        }
        if (p.y >= yMin) {
            if (p.x >= lineOrigin.x && p.x <= lineOrigin.x + width) {
                CGPoint relativePoint = CGPointMake(p.x - lineOrigin.x, p.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                break;
            }
        }
    }
    CFRelease(frame);
    CGPathRelease(path);
    return idx;

}

@end
