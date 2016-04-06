//
//  FaceManagerCenterViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/1.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceManagerCenterViewController.h"

@interface FaceManagerCenterViewController ()

@end

@implementation FaceManagerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的表情";
    
    [self addleftBtn];
    [self addRightBtn];
}

- (void)addleftBtn
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)addRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setTitle:@"排序" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark -- action
- (void)closeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sortAction:(UIButton *)sender
{
    
}


@end
