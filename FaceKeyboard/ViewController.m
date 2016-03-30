//
//  ViewController.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ViewController.h"
#import "ChatKeyBoard.h"
#import "FacePanel.h"

@interface ViewController ()

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FacePanel *facePanel = [FacePanel facePanel];
    [self.view addSubview:facePanel];
    
    
//    self.chatKeyBoard = [ChatKeyBoard keyBoard];
//    [self.view addSubview:self.chatKeyBoard];
}

- (IBAction)click:(id)sender {
    self.chatKeyBoard.chatToolBar.haveSwitchBarViewBtn = !self.chatKeyBoard.chatToolBar.haveSwitchBarViewBtn;
}

- (IBAction)clickVoice:(id)sender {
    self.chatKeyBoard.chatToolBar.haveVoiceBtn = !self.chatKeyBoard.chatToolBar.haveVoiceBtn;
}

- (IBAction)clickface:(id)sender {
    self.chatKeyBoard.chatToolBar.haveFaceBtn = !self.chatKeyBoard.chatToolBar.haveFaceBtn;
}

- (IBAction)clickmore:(id)sender {
    self.chatKeyBoard.chatToolBar.haveMoreBtn = !self.chatKeyBoard.chatToolBar.haveMoreBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
