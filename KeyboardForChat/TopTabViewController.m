//
//  TopTabViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/8.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "TopTabViewController.h"
#import "Child1ViewController.h"
#import "Child2ViewController.h"
#import "Child3ViewController.h"

@interface TopTabViewController ()
/** 正在显示的控制器 */
@property (nonatomic, weak) UIViewController *showingVc;

@property (nonatomic, weak) UIButton *child1;
@property (nonatomic, weak) UIButton *child2;
@property (nonatomic, weak) UIButton *child3;

@end

@implementation TopTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGFloat w = self.view.frame.size.width;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, 64, w / 3.0f, 44);
    btn1.tag = 0;
    [btn1 setTitle:@"Child1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(clickChild:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame), 64, w / 3.0f, 44);
    btn2.tag = 1;
    [btn2 setTitle:@"Child2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 addTarget:self action:@selector(clickChild:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame), 64, w / 3.0f, 44);
    btn3.tag = 2;
    [btn3 setTitle:@"Child3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor purpleColor];
    [btn3 addTarget:self action:@selector(clickChild:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    [self addChildViewController:[[Child1ViewController alloc] init]];
    [self addChildViewController:[[Child2ViewController alloc] init]];
    [self addChildViewController:[[Child3ViewController alloc] init]];
    
}

- (void)clickChild:(UIButton *)button
{
    // 移除其他控制器的view
    [self.showingVc.view removeFromSuperview];
    
    // 添加控制器的view
    self.showingVc = self.childViewControllers[button.tag];
    self.showingVc.view.frame = CGRectMake(0, 64+44, self.view.frame.size.width, self.view.frame.size.height - 64-44);
    [self.view addSubview:self.showingVc.view];
}

@end
