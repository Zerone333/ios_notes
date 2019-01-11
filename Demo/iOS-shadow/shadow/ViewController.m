//
//  ViewController.m
//  shadow
//
//  Created by Lee on 2018/12/14.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    CGRect frame = CGRectMake(100, 100, 100, 100);
//    UIView *testView = [[UIView alloc] initWithFrame:frame];
//    testView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:testView];
//
//
//    testView.layer.shadowColor = [UIColor blackColor].CGColor;
//    testView.layer.shadowOffset = CGSizeMake(0,0);
//    testView.layer.shadowOpacity = 0.12;
//    testView.layer.shadowRadius = 8;
    CGRect frame = CGRectMake(100, 100, 200, 200);
    UIView *outsideRound = [[UIView alloc] initWithFrame:frame];
    outsideRound.backgroundColor = [UIColor redColor];
    outsideRound.layer.borderWidth = 6;
    outsideRound.layer.cornerRadius = CGRectGetWidth(frame) /2;
    outsideRound.layer.borderColor = [UIColor whiteColor].CGColor;
    outsideRound.frame = frame;
    
    outsideRound.layer.shadowColor = [UIColor blackColor].CGColor;
    outsideRound.layer.shadowOffset = CGSizeMake(0,8);
    outsideRound.layer.shadowOpacity = 0.5;
    outsideRound.layer.shadowRadius = 8;
    [self.view addSubview:outsideRound];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"sdfsdfsdf";
    label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake(300, 100, 100, 100);
    label.layoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    [label sizeToFit];
    [self.view addSubview:label];
    
//    //实现模糊效果
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    //毛玻璃视图
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
//    effectView.frame = testView.bounds;
//
//    [testView addSubview:effectView];
    
}


@end
