//
//  ToolbarView.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFTextView.h"
#import "RFRecordButton.h"

typedef NS_ENUM(NSInteger, ButKind)
{
    kButKindVoice,
    kButKindFace,
    kButKindMore,
    kButKindSwitchBarViewBtn
};

@class ChatToolBar;
@protocol ChatToolBarDelegate <NSObject>

@optional
- (void)chatToolBar:(ChatToolBar *)toolBar voiceBtnPressed:(BOOL)select;
- (void)chatToolBar:(ChatToolBar *)toolBar faceBtnPressed:(BOOL)select;
- (void)chatToolBar:(ChatToolBar *)toolBar moreBtnPressed:(BOOL)select;
- (void)chatToolBar:(ChatToolBar *)toolBar switchToolBarBtnPressed:(BOOL)select;

- (void)chatToolBarDidStartRecording:(ChatToolBar *)toolBar;
- (void)chatToolBarDidCancelRecording:(ChatToolBar *)toolBar;
- (void)chatToolBarDidFinishRecoding:(ChatToolBar *)toolBar;
- (void)chatToolBarWillCancelRecoding:(ChatToolBar *)toolBar;
- (void)chatToolBarContineRecording:(ChatToolBar *)toolBar;

- (void)chatToolBarTextViewDidBeginEditing:(UITextView *)textView;
- (void)chatToolBarSendText:(NSString *)text;
- (void)chatToolBarTextViewDidChange:(UITextView *)textView;
@end


@interface ChatToolBar : UIImageView

/** ChatToolBar代理 */
@property (nonatomic, weak) id delegate;

/** 切换barView按钮 */
@property (nonatomic, readonly) UIButton *switchBarViewBtn;
/** 语音按钮 */
@property (nonatomic, readonly) UIButton *voiceBtn;
/** 表情按钮 */
@property (nonatomic, readonly) UIButton *faceBtn;
/** more按钮 */
@property (nonatomic, readonly) UIButton *moreBtn;
/** 输入文本框 */
@property (nonatomic, readonly) RFTextView *textView;
/** 按住录制语音按钮 */
@property (nonatomic, readonly) RFRecordButton *recordBtn;

/** 输入状态监测 */
@property(readonly) BOOL isInputting;

/** 默认为no */
@property (nonatomic, assign) BOOL haveSwitchBarViewBtn;
/** 以下默认为yes*/
@property (nonatomic, assign) BOOL haveVoiceBtn;
@property (nonatomic, assign) BOOL haveFaceBtn;
@property (nonatomic, assign) BOOL haveMoreBtn;


/** 设置按钮图片 */
- (void)setBtn:(ButKind)btnKind normalStateImageStr:(NSString *)normalStr
selectStateImageStr:(NSString *)selectStr highLightStateImageStr:(NSString *)highLightStr;

@end
