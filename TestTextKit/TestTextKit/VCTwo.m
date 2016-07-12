//
//  VCTwo.m
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import "VCTwo.h"
#import "CircleView.h"
@implementation VCTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"OS7增加了一项用户偏好设置：动态字体，用户可以通过显示与亮度-文字大小设置面板来修改设备上所有字体的尺寸。为了支持这个特性，意味着不要用systemFontWithSize:,而要用新的字体选择器preferredFontForTextStyle:。iOS提供了六种样式：标题，正文，副标题，脚注，标题1，标题2。例如引用苹果官方的一句话，“Objective-C不会消失，Swift和Objective-C可同时用于Cocoa和CocoaTouch开发。”因此，你仍然可以继续使用Objective-C。不过，苹果似乎鼓励你使用Swift进行新的开发，而不是希望你重写所有的Objective-C代码。我们猜测苹果在未来的框架和API开发中将会逐渐减少使用Objective-C语言，甚至有一天会弃用Objective-C，所以早作准备吧!";
    [self.textView.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:str];
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self updateExclusionPaths];
    
}
- (void)preferredContentSizeChanged:(NSNotification *)nofi {
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
- (void)updateExclusionPaths {
    CGRect ovalFrame = [self.textView convertRect:self.circleView.bounds fromView:self.circleView];
    ovalFrame.origin.x -= self.textView.textContainerInset.left;
    ovalFrame.origin.y -= self.textView.textContainerInset.top;
    self.textView.textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithOvalInRect:ovalFrame]];
}
@end
