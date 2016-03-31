//
//  ChatKeyBoard.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ChatKeyBoard.h"
#import "Macrol.h"
#import "MoreItem.h"

@interface ChatKeyBoard () <ChatToolBarDelegate>

@property (nonatomic, strong) ChatToolBar *chatToolBar;
@property (nonatomic, strong) FacePanel *facePanel;
@property (nonatomic, strong) MorePanel *morePanel;

@end

@implementation ChatKeyBoard

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
    if (self) {
        self.chatToolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kChatToolBarHeight)];
        self.chatToolBar.delegate = self;
        [self addSubview:self.chatToolBar];
        
        self.facePanel = [[FacePanel alloc] initWithFrame:CGRectMake(0, kChatKeyBoardHeight-kFacePanelHeight, kScreenWidth, kFacePanelHeight)];
        [self addSubview:self.facePanel];
        
        self.morePanel = [[MorePanel alloc] initWithFrame:self.facePanel.frame];
        [self addSubview:self.morePanel];
        
        [self setToolBar];
        [self setMoreItems];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [self addObserver:self forKeyPath:@"self.chatToolBar.frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)keyBoardWillChangeFrame:(NSNotification *)notification
{
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
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
            CGFloat ty = [[UIScreen mainScreen] bounds].size.height - rect.origin.y;
            self.transform = CGAffineTransformMakeTranslation(0, -ty);
        }
        
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"self.chatToolBar.frame"]) {
        NSLog(@"%@", change);
        CGRect newRect = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        CGRect oldRect = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGFloat changeHeight = newRect.size.height - oldRect.size.height;
        self.frame = CGRectMake(0, self.frame.origin.y - changeHeight, self.frame.size.width, self.frame.size.height + changeHeight);
        self.facePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kFacePanelHeight, CGRectGetWidth(self.frame), kFacePanelHeight);
        self.morePanel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kMorePanelHeight, CGRectGetWidth(self.frame), kMorePanelHeight);
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
- (void)chatToolBar:(ChatToolBar *)toolBar switchToolBarBtnPressed:(BOOL)select keyBoardState:(BOOL)change
{
    
}


- (void)setToolBar
{
    [self.chatToolBar setBtn:kButKindFace normalStateImageStr:@"face" selectStateImageStr:@"keyboard" highLightStateImageStr:@"face_HL"];
    [self.chatToolBar setBtn:kButKindVoice normalStateImageStr:@"voice" selectStateImageStr:@"keyboard" highLightStateImageStr:@"voice_HL"];
    [self.chatToolBar setBtn:kButKindMore normalStateImageStr:@"more_ios" selectStateImageStr:nil highLightStateImageStr:@"more_ios_HL"];
    [self.chatToolBar setBtn:kButKindSwitchBar normalStateImageStr:@"jobDownArrow" selectStateImageStr:@"upArrow"highLightStateImageStr:nil];
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
