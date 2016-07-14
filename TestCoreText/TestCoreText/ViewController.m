//
//  ViewController.m
//  TestCoreText
//
//  Created by ZhaoNing on 16/7/14.
//  Copyright © 2016年 ZhaoNing. All rights reserved.
//

#import "ViewController.h"
#import "CTLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CTLabel *label = [CTLabel new];
    label.numberOfLines = 0;
    label.linkString = @"UIFont";
    label.userInteractionEnabled = YES;
    label.text = @"NSFontAttributeName:UIFont preferredFontForTextStyle:UIFontTextStyleBody";
    label.frame = CGRectMake(50, 50, 200, 100);
    [self.view addSubview:label];
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text attributes:attrs];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[label.text rangeOfString:@"UIFont"]];
    label.attributedText = attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
