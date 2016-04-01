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
#import "FaceStoreViewController.h"
#import "FaceManagerCenterViewController.h"

@interface ViewController () <ChatKeyBoardDelegate>

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (weak, nonatomic) IBOutlet UILabel *voiceState;
@property (weak, nonatomic) IBOutlet UILabel *sendText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    self.chatKeyBoard.delegate = self;
    
    [self.view addSubview:self.chatKeyBoard];
}

- (IBAction)switchBar:(UISwitch *)sender
{
    self.chatKeyBoard.allowSwitchBar = sender.on;
}

- (IBAction)switchVoice:(UISwitch *)sender
{
    self.chatKeyBoard.allowVoice = sender.on;
}

- (IBAction)switchFace:(UISwitch *)sender
{
    self.chatKeyBoard.allowFace = sender.on;
}

- (IBAction)switchMore:(UISwitch *)sender
{
    self.chatKeyBoard.allowMore = sender.on;
}

#pragma mark -- 语音状态
- (void)chatKeyBoardDidStartRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"正在录音";
}
- (void)chatKeyBoardDidCancelRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"已经取消录音";
}
- (void)chatKeyBoardDidFinishRecoding:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"已经完成录音";
}
- (void)chatKeyBoardWillCancelRecoding:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"将要取消录音";
}
- (void)chatKeyBoardContineRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"继续录音";
}

#pragma mark -- 表情

- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceSize:(NSInteger)faceSize faceName:(NSString *)faceName delete:(BOOL)isDelete;
{
    
}
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard
{
    FaceStoreViewController *faceStore = [[FaceStoreViewController alloc] init];
    [self.navigationController pushViewController:faceStore animated:YES];
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard
{
    FaceManagerCenterViewController *faceManage = [[FaceManagerCenterViewController alloc] init];
    [self.navigationController pushViewController:faceManage animated:YES];

}

#pragma mark -- 更多
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index
{
    NSString *message = [NSString stringWithFormat:@"选择的ItemIndex %zd", index];
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"ItemIndex" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertV show];
}

#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text
{
    self.sendText.text = text;
}

@end
