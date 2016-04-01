//
//  ChatKeyBoard.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ChatKeyBoard.h"
#import "ChatToolBar.h"
#import "FacePanel.h"
#import "MorePanel.h"
#import "Macrol.h"
#import "MoreItem.h"
#import "OfficialAccountToolbar.h"

@interface ChatKeyBoard () <ChatToolBarDelegate, FacePanelDelegate, MorePannelDelegate>

@property (nonatomic, strong) ChatToolBar *chatToolBar;
@property (nonatomic, strong) FacePanel *facePanel;
@property (nonatomic, strong) MorePanel *morePanel;
@property (nonatomic, strong) OfficialAccountToolbar *OAtoolbar;

@end

@implementation ChatKeyBoard

#pragma mark -- life

+ (instancetype)keyBoard
{
    return [[self alloc] initWithFrame:CGRectMake(0, kScreenHeight - kChatToolBarHeight, kScreenWidth, kChatKeyBoardHeight)];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [self removeObserver:self forKeyPath:@"self.chatToolBar.frame"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.chatToolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kChatToolBarHeight)];
        self.chatToolBar.delegate = self;
        [self addSubview:self.chatToolBar];
        
        self.facePanel = [[FacePanel alloc] initWithFrame:CGRectMake(0, kChatKeyBoardHeight-kFacePanelHeight, kScreenWidth, kFacePanelHeight)];
        self.facePanel.delegate = self;
        [self addSubview:self.facePanel];
        
        self.morePanel = [[MorePanel alloc] initWithFrame:self.facePanel.frame];
        self.morePanel.delegate = self;
        [self addSubview:self.morePanel];
        
        self.OAtoolbar = [[OfficialAccountToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), kScreenWidth, kChatToolBarHeight)];
        [self addSubview:self.OAtoolbar];
        
        [self setToolBar];
        [self setMoreItems];
        
        __weak __typeof(self) weakself = self;
        self.OAtoolbar.switchAction = ^(){
            [UIView animateWithDuration:0.25 animations:^{
                weakself.OAtoolbar.frame = CGRectMake(0, CGRectGetMaxY(weakself.frame), CGRectGetWidth(weakself.frame), kChatToolBarHeight);
                CGFloat y = weakself.frame.origin.y;
                y = kScreenHeight - self.chatToolBar.frame.size.height;
                weakself.frame = CGRectMake(0, y, weakself.frame.size.width, weakself.frame.size.height);
            }];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [self addObserver:self forKeyPath:@"self.chatToolBar.frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}


#pragma mark -- 跟随键盘的坐标变化
- (void)keyBoardWillChangeFrame:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.chatToolBar.faceSelected) {
            self.morePanel.hidden = YES;
            self.facePanel.hidden = NO;
            self.frame = CGRectMake(0, kScreenHeight-CGRectGetHeight(self.frame), kScreenWidth, CGRectGetHeight(self.frame));
            self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kFacePanelHeight, CGRectGetWidth(self.frame), kFacePanelHeight);
            self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kFacePanelHeight);
            
        }else if (self.chatToolBar.moreFuncSelected){
            self.morePanel.hidden = NO;
            self.facePanel.hidden = YES;
            self.frame = CGRectMake(0, kScreenHeight-CGRectGetHeight(self.frame), kScreenWidth, CGRectGetHeight(self.frame));
            self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kMorePanelHeight, CGRectGetWidth(self.frame), kMorePanelHeight);
            self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kFacePanelHeight);
            
        }else if (self.chatToolBar.voiceSelected && !self.chatToolBar.textView.isFirstResponder){
            CGFloat y = self.frame.origin.y;
            y = kScreenHeight - self.chatToolBar.frame.size.height;
            self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
            
        }else{
            CGRect begin = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            CGRect end = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
            CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

           
            if(begin.size.height>0 && (begin.origin.y-end.origin.y>0))
            {
                // 键盘弹起 (包括，第三方键盘回调三次问题，监听仅执行最后一次)
                CGFloat targetY = end.origin.y - (CGRectGetHeight(self.frame) - kMorePanelHeight);
                self.frame = CGRectMake(0, targetY, CGRectGetWidth(self.frame), self.frame.size.height);
            }
            else if (end.origin.y == kScreenHeight && begin.origin.y!=end.origin.y && duration > 0)
            {
                //键盘收起
                CGFloat targetY = end.origin.y - (CGRectGetHeight(self.frame) - kMorePanelHeight);
                self.frame = CGRectMake(0, targetY, CGRectGetWidth(self.frame), self.frame.size.height);
            }
            else if ((begin.origin.y-end.origin.y<0) && duration == 0)
            {   //键盘切换
                CGFloat targetY = end.origin.y - (CGRectGetHeight(self.frame) - kMorePanelHeight);
                self.frame = CGRectMake(0, targetY, CGRectGetWidth(self.frame), self.frame.size.height);
            }
        }
    }];
}

#pragma mark -- kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"self.chatToolBar.frame"]) {
        
        CGRect newRect = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        CGRect oldRect = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGFloat changeHeight = newRect.size.height - oldRect.size.height;
        self.frame = CGRectMake(0, self.frame.origin.y - changeHeight, self.frame.size.width, self.frame.size.height + changeHeight);
        self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kFacePanelHeight, CGRectGetWidth(self.frame), kFacePanelHeight);
        self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kMorePanelHeight, CGRectGetWidth(self.frame), kMorePanelHeight);
        self.OAtoolbar.frame = CGRectMake(0, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), kChatToolBarHeight);
    }
}

#pragma mark -- ChatToolBarDelegate

- (void)chatToolBar:(ChatToolBar *)toolBar voiceBtnPressed:(BOOL)select keyBoardState:(BOOL)change
{
    if (select && change == NO) {
        
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat y = self.frame.origin.y;
            y = kScreenHeight - self.chatToolBar.frame.size.height;
            self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
        }];
    }
}
- (void)chatToolBar:(ChatToolBar *)toolBar faceBtnPressed:(BOOL)select keyBoardState:(BOOL)change
{
    if (select && change == NO)
    {
        self.morePanel.hidden = YES;
        self.facePanel.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, kScreenHeight-CGRectGetHeight(self.frame), kScreenWidth, CGRectGetHeight(self.frame));
            self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kFacePanelHeight, CGRectGetWidth(self.frame), kFacePanelHeight);
            self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kFacePanelHeight);
        }];
    }
}
- (void)chatToolBar:(ChatToolBar *)toolBar moreBtnPressed:(BOOL)select keyBoardState:(BOOL)change
{
    if (select && change == NO)
    {
        self.morePanel.hidden = NO;
        self.facePanel.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, kScreenHeight-CGRectGetHeight(self.frame), kScreenWidth, CGRectGetHeight(self.frame));
            self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kMorePanelHeight, CGRectGetWidth(self.frame), kMorePanelHeight);
            self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kFacePanelHeight);
        }];
    }
}
- (void)chatToolBarSwitchToolBarBtnPressed:(ChatToolBar *)toolBar keyBoardState:(BOOL)change
{
    if (change == NO)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat y = self.frame.origin.y;
            y = kScreenHeight - kChatToolBarHeight;
            self.frame = CGRectMake(0, kScreenHeight, self.frame.size.width, self.frame.size.height);
            self.OAtoolbar.frame = CGRectMake(0, 0, self.frame.size.width, kChatToolBarHeight);
            self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
        }];
    }
    else
    {
        CGFloat y = kScreenHeight - kChatToolBarHeight;
        self.frame = CGRectMake(0, kScreenHeight, self.frame.size.width, self.frame.size.height);
        self.OAtoolbar.frame = CGRectMake(0, 0, self.frame.size.width, kChatToolBarHeight);
        self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
    }
}

- (void)chatToolBarDidStartRecording:(ChatToolBar *)toolBar
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardDidStartRecording:)]) {
        [self.delegate chatKeyBoardDidStartRecording:self];
    }
}
- (void)chatToolBarDidCancelRecording:(ChatToolBar *)toolBar
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardDidCancelRecording:)]) {
        [self.delegate chatKeyBoardDidCancelRecording:self];
    }
}
- (void)chatToolBarDidFinishRecoding:(ChatToolBar *)toolBar
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardDidFinishRecoding:)]) {
        [self.delegate chatKeyBoardDidFinishRecoding:self];
    }
}
- (void)chatToolBarWillCancelRecoding:(ChatToolBar *)toolBar
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardWillCancelRecoding:)]) {
        [self.delegate chatKeyBoardWillCancelRecoding:self];
    }
}
- (void)chatToolBarContineRecording:(ChatToolBar *)toolBar
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardContineRecording:)]) {
        [self.delegate chatKeyBoardContineRecording:self];
    }
}

- (void)chatToolBarTextViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardTextViewDidBeginEditing:)]) {
        [self.delegate chatKeyBoardTextViewDidBeginEditing:textView];
    }
}
- (void)chatToolBarSendText:(NSString *)text
{
    
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardSendText:)]) {
        [self.delegate chatKeyBoardSendText:text];
    }
    //内容清空
    self.chatToolBar.textView.text = @"";
}
- (void)chatToolBarTextViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardTextViewDidChange:)]) {
        [self.delegate chatKeyBoardTextViewDidChange:textView];
    }
}

#pragma mark -- FacePanelDelegate
- (void)facePanelFacePicked:(FacePanel *)facePanel faceSize:(NSInteger)faceSize faceName:(NSString *)faceName delete:(BOOL)isDelete
{
    NSString *text = self.chatToolBar.textView.text;
    if (isDelete) {
        [self.chatToolBar setTextContent:[text substringToIndex:text.length - 1]];
    }else {
        [self.chatToolBar setTextContent:[text stringByAppendingString:faceName]];
    }
    
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardFacePicked:faceSize:faceName:delete:)]) {
        [self.delegate chatKeyBoardFacePicked:self faceSize:faceSize faceName:faceName delete:isDelete];
    }
}

- (void)facePanelSendTextAction:(FacePanel *)facePanel
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardSendText:)]) {
        [self.delegate chatKeyBoardSendText:self.chatToolBar.textView.text];
    }
    [self.chatToolBar clearText];
}

- (void)facePanelAddSubject:(FacePanel *)facePanel
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardAddFaceSubject:)]) {
        [self.delegate chatKeyBoardAddFaceSubject:self];
    }
}
- (void)facePanelSetSubject:(FacePanel *)facePanel
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoardSetFaceSubject:)]) {
        [self.delegate chatKeyBoardSetFaceSubject:self];
    }
}

#pragma mark -- MorePannelDelegate
- (void)morePannel:(MorePanel *)morePannel didSelectItemIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(chatKeyBoard:didSelectMorePanelItemIndex:)]) {
        [self.delegate chatKeyBoard:self didSelectMorePanelItemIndex:index];
    }
}

#pragma mark -- 配置keyboard
- (void)configChatToolBar
{
    [self setToolBar];
}

- (void)configChatMorePanel
{
    [self setMoreItems];
}

#pragma mark -- set方法
-(void)setAllowVoice:(BOOL)allowVoice
{
    self.chatToolBar.allowVoice = allowVoice;
}

- (void)setAllowFace:(BOOL)allowFace
{
    self.chatToolBar.allowFace = allowFace;
}

- (void)setAllowMore:(BOOL)allowMore
{
    self.chatToolBar.allowMoreFunc = allowMore;
}

- (void)setAllowSwitchBar:(BOOL)allowSwitchBar
{
    self.chatToolBar.allowSwitchBar = allowSwitchBar;
}

#pragma mark -- 配置ChatKeyBoard
- (void)setToolBar
{
    [self.chatToolBar setBtn:kButKindFace normalStateImageStr:@"face" selectStateImageStr:@"keyboard" highLightStateImageStr:@"face_HL"];
    [self.chatToolBar setBtn:kButKindVoice normalStateImageStr:@"voice" selectStateImageStr:@"keyboard" highLightStateImageStr:@"voice_HL"];
    [self.chatToolBar setBtn:kButKindMore normalStateImageStr:@"more_ios" selectStateImageStr:nil highLightStateImageStr:@"more_ios_HL"];
    [self.chatToolBar setBtn:kButKindSwitchBar normalStateImageStr:@"switchDown" selectStateImageStr:@"" highLightStateImageStr:nil];
}

- (void)setMoreItems
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
    [self.morePanel loadMoreItems:@[item1, item2, item3, item4, item5,item6,item7,item8,item9]];
}

@end
