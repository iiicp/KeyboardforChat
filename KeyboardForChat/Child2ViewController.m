//
//  Child2ViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/8.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "Child2ViewController.h"

@interface Child2ViewController ()

@end

@implementation Child2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f  blue:arc4random_uniform(255)/255.f  alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
