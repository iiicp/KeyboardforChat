//
//  ViewController.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ViewController.h"
#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
#import "FaceStoreViewController.h"
#import "FaceManagerCenterViewController.h"


@interface ViewController () <ChatKeyBoardDelegate, ChatKeyBoardDataSource>

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (weak, nonatomic) IBOutlet UILabel *voiceState;
@property (weak, nonatomic) IBOutlet UILabel *sendText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  导航栏不透明，则用这个初始化方法
     *  NO 表示导航栏不透明
     *  YES 表示导航栏透明
     *
     *  导航栏透明默认使用 [ChatKeyBoard keyBoard]
     */
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    [self.view addSubview:self.chatKeyBoard];
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceSubjectModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
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
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:faceStore];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard
{
    FaceManagerCenterViewController *faceManage = [[FaceManagerCenterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:faceManage];
    [self presentViewController:nav animated:YES completion:nil];
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
