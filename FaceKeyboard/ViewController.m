//
//  ViewController.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ViewController.h"
#import "ToolBarView.h"

@interface ViewController ()

/** <#注释#> */
@property (nonatomic, strong) ToolBarView *barView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    self.barView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, height-40, width, 40)];
    self.barView.backgroundColor = [UIColor purpleColor];
    
    [self.barView setBtn:kButKindFace normalStateImageStr:@"face_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
     [self.barView setBtn:kButKindVoice normalStateImageStr:@"voice_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
     [self.barView setBtn:kButKindMore normalStateImageStr:@"more_ios7" selectStateImageStr:nil highLightStateImageStr:nil];
    
    [self.view addSubview:self.barView];
}

- (IBAction)click:(id)sender {
    
    self.barView.haveMoreBtn = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
