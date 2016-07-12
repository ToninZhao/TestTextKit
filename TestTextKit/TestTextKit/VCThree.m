//
//  VCThree.m
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import "VCThree.h"
@interface VCThree()
@property (weak, nonatomic) UITextView *otherTextView;
@property (weak, nonatomic) UITextView *thirdTextView;
@end
@implementation VCThree
- (void)viewDidLoad {
    [super viewDidLoad];
    NSTextStorage *shareTextStorge = self.textView.textStorage;
    NSLog(@"%p", shareTextStorge);
    [shareTextStorge replaceCharactersInRange:NSMakeRange(0, 0) withString:@"了一项用户偏好设置：动态字体，用户可以通过显示与亮度-文字大小设置面板来修改设备上所有字体的尺寸。为了支持这个特性，意味着不要用systemFontWithSize:,而要用新的字体选择器preferredFontForTextStyle:。iOS提供了六种样式：标题，正文，副标题，脚注，标题1，标题2。例如引用苹果官方的一句话，“Objective-C不会消失，"];
    
    NSLayoutManager *otherLayoutManager = [NSLayoutManager new];
    [shareTextStorge addLayoutManager: otherLayoutManager];
    
    NSTextContainer *otherTextContainer = [NSTextContainer new];
    [otherLayoutManager addTextContainer:otherTextContainer];
    
    UITextView *otherTextView = [[UITextView alloc] initWithFrame:self.oneView.bounds textContainer:otherTextContainer];
    otherTextView.backgroundColor = self.oneView.backgroundColor;
    otherTextView.translatesAutoresizingMaskIntoConstraints = YES;
    otherTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    otherTextView.scrollEnabled = NO;
    
    [self.oneView addSubview:otherTextView];
    self.otherTextView = otherTextView;
    
    
    NSLayoutManager *thirdLayoutManager = [NSLayoutManager new];
    [shareTextStorge addLayoutManager: thirdLayoutManager];
    
    NSTextContainer *thirdTextContainer = [NSTextContainer new];
    [thirdLayoutManager addTextContainer:thirdTextContainer];
    
    UITextView *thirdTextView = [[UITextView alloc] initWithFrame:self.twoView.bounds textContainer:thirdTextContainer];
    thirdTextView.backgroundColor = self.twoView.backgroundColor;
    thirdTextView.translatesAutoresizingMaskIntoConstraints = YES;
    thirdTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    thirdTextView.scrollEnabled = NO;
    
    [self.twoView addSubview:thirdTextView];
    self.thirdTextView = thirdTextView;
}
@end
