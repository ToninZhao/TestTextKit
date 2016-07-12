//
//  CircleView.m
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView
- (void)drawRect:(CGRect)rect {
    [self.tintColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:self.bounds] fill];
}
@end
