//
//  FaceStoreViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/1.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceStoreViewController.h"

@interface FaceStoreViewController ()

@end

@implementation FaceStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"表情商店";
    [self addleftBtn];
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

#pragma mark -- action
- (void)closeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
