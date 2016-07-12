//
//  VCTwo.h
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleView;
@interface VCTwo : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet CircleView *circleView;

@end
