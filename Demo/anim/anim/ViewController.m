//
//  ViewController.m
//  anim
//
//  Created by Lee on 2019/1/3.
//  Copyright © 2019年 Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, weak) UILabel *topRightValueLabel;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) NSInteger times;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 遮罩显示，镂空
    UIView *view1 =[[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    self.view1 = view1;
    
    UIBezierPath *round  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *round2  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [round appendPath:round2];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame         = CGRectMake(0, 0, 200, 200);
    layer.path           = round.CGPath;
    layer.fillColor      = [UIColor colorWithWhite:0 alpha:1].CGColor;
    layer.fillRule       = kCAFillRuleEvenOdd;  //重点， 填充规则
    self.view1.layer.mask = layer;
    
    // 核心动画
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(100, 320, 100, 100);
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.autoreverses = NO;
    animation.repeatCount = 0;
    animation.duration = 0.01;
    animation.beginTime = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.fromValue = @(0);
    animation4.toValue = @(1);
    animation4.autoreverses = NO;
    animation4.repeatCount = 0;
    animation4.duration = 5;
    animation4.beginTime = 2;
    animation4.removedOnCompletion = NO;
    animation4.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation5.fromValue = @(0);
    animation5.toValue = @(2);
    animation5.autoreverses = NO;   // 动画结束后，反向再播放一次
    animation5.repeatCount = 0;
    animation5.duration = 5;
    animation5.beginTime = 2;
    animation5.removedOnCompletion = NO;
    animation5.fillMode = kCAFillModeForwards;

    CAAnimationGroup *animation3 = [CAAnimationGroup animation];
    animation3.animations = @[animation, animation4, animation5];
    animation3.duration = 5;
    animation3.removedOnCompletion = YES;   // 动画完后，保持动画前的原始效果
    animation3.fillMode = kCAFillModeForwards;

    [view2.layer addAnimation:animation3 forKey:@"test"];
    
    // 转场动画
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 50, 50)];
    testView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testView];
    CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI, 0, 0, 1.0);
    CABasicAnimation *animation8 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation8.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation8.duration  =  3;
    animation8.autoreverses = NO;
    animation8.cumulative = YES;
    animation8.fillMode = kCAFillModeForwards;
    animation8.repeatCount = 0;
    //以下两行同时设置才能保持移动后的位置状态不变
    //rotationAnimation.fillMode=kCAFillModeForwards;
    //rotationAnimation.removedOnCompletion = NO;
    [testView.layer addAnimation:animation8 forKey:@"sd"];
    
    // 移动动画
    UIView *testView2 = [[UIView alloc] initWithFrame:CGRectMake(80, 400, 50, 50)];
    testView2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:testView2];
    
    // 初始化UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 首先设置一个起始点
    CGPoint startPoint = CGPointMake(CGRectGetMinX(testView2.frame), CGRectGetMinY(testView2.frame));
    // 设置一个终点
    CGPoint endPoint = CGPointMake(CGRectGetMinX(testView2.frame) - 40, CGRectGetMinY(testView2.frame) + 100);
    // 以起始点为路径的起点
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    CAKeyframeAnimation *animation10 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    animation10.path = path.CGPath;
    // 重复次数为最大值
    animation10.repeatCount = FLT_MAX;
    animation10.removedOnCompletion = NO;
    animation10.fillMode = kCAFillModeForwards;
    
    animation10.duration  =  3;
    animation10.autoreverses = NO;
    animation10.cumulative = YES;
    animation10.fillMode = kCAFillModeForwards;
    animation10.repeatCount = 0;
    [testView2.layer addAnimation:animation10 forKey:@"sd"];
    
    UILabel *topRightValueLabel = [[UILabel alloc] init];
    topRightValueLabel.frame = CGRectMake(40, 230, 100, 100);
    topRightValueLabel.text = @"10";
    [self.view addSubview:topRightValueLabel];
    self.topRightValueLabel = topRightValueLabel;
    
    
}


- (void)gravidityValueChangeAnimate:(NSInteger)times gravidityValue:(NSInteger)gravidityValue {
    if (times < 0) {
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        self.topRightValueLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)gravidityValue + (10 - times)];
        NSLog(@"gravidityValue%@", [NSString stringWithFormat:@"%lu", (unsigned long)gravidityValue + (10 - times)]);
        self.topRightValueLabel.frame = CGRectMake(10, 500, 100, 100);
    } completion:^(BOOL finished) {
        if (finished) {
            [self gravidityValueChangeAnimate:times -1 gravidityValue:gravidityValue];
        }
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.times = 10;
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
//    timer.frameInterval = 2;
    timer.preferredFramesPerSecond = 0.02;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
    
}

- (void)updateValue:(NSTimer *)timer {
    if (self.times < 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.times -= 1;
    self.topRightValueLabel.text = [NSString stringWithFormat:@"%lu", self.topRightValueLabel.text.integerValue + 1];
    NSLog(@"gravidityValue%@",  self.topRightValueLabel.text);
   
}

@end
