//
//  VCFour.m
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import "VCFour.h"
#import "HighlightTextStorage.h"
@interface VCFour()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation VCFour
{
    HighlightTextStorage *_textStorage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _textStorage = [HighlightTextStorage new];
    [_textStorage addLayoutManager:_textView.layoutManager];
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"MPMoviePlayerController是一个简单易用的视频播放控件，可以播放本地文件和网络流媒体，支持mov、mp4、mpv、3gp等H.264和MPEG-4视频*编码*格式，*支持拖动进度条*、快进、后退、暂停、全屏等操作，并为开发者提供了一系列播放状态事件通知。使用时先设置URL，然后把它的view add到某个parent view里，再调用play即可。"];
    _textView.delegate = self;
}
- (void)preferredContentSizeChanged:(NSNotification *)noti {
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
@end
