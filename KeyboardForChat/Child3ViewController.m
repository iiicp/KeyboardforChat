//
//  Child3ViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/8.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "Child3ViewController.h"

@interface Child3ViewController ()

@end

@implementation Child3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f  blue:arc4random_uniform(255)/255.f  alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
