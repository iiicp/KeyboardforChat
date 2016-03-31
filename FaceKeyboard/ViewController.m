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
#import "MorePanel.h"
#import "MoreItem.h"

@interface ViewController ()

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FacePanel *facePanel = [FacePanel facePanel];
//    [self.view addSubview:facePanel];
    
    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    [self.view addSubview:self.chatKeyBoard];
    
//    MorePanel *pannel = [MorePanel morePannel];
//    
//    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
//    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
//    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
//    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
//    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
//    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
//    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
//    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
//    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
//    
//    [pannel loadMoreItems:@[item1, item2, item3, item4, item5,item6,item7,item8,item9]];
//    [self.view addSubview:pannel];
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
