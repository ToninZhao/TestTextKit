//
//  ViewController.m
//  TestTextKit
//
//  Created by ToninZhao on 16/7/12.
//  Copyright © 2016年 Tonin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributesStringLabel];
}

- (void)setAttributesStringLabel {
    NSString *str = @"tonin, little color, hello";
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont preferredFontForTextStyle: UIFontTextStyleBody]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[str rangeOfString:@"tonin"]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[str rangeOfString:@"little color"]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Papyrus" size:50] range:NSMakeRange(10, 10)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[str rangeOfString:@"hello"]];
    
    [attributedString removeAttribute:NSFontAttributeName range:[str rangeOfString:@"little"]];
    
    self.myLabel.attributedText = attributedString;
}

@end
