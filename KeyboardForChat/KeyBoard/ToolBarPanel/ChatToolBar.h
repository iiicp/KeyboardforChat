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
    kButKindSwitchBar
};

@class ChatToolBar;
@protocol ChatToolBarDelegate <NSObject>

@optional
- (void)chatToolBar:(ChatToolBar *)toolBar voiceBtnPressed:(BOOL)select keyBoardState:(BOOL)change;
- (void)chatToolBar:(ChatToolBar *)toolBar faceBtnPressed:(BOOL)select keyBoardState:(BOOL)change;
- (void)chatToolBar:(ChatToolBar *)toolBar moreBtnPressed:(BOOL)select keyBoardState:(BOOL)change;
- (void)chatToolBarSwitchToolBarBtnPressed:(ChatToolBar *)toolBar keyBoardState:(BOOL)change;

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

@property (nonatomic, weak) id<ChatToolBarDelegate> delegate;

/** 切换barView按钮 */
@property (nonatomic, readonly, strong) UIButton *switchBarBtn;
/** 语音按钮 */
@property (nonatomic, readonly, strong) UIButton *voiceBtn;
/** 表情按钮 */
@property (nonatomic, readonly, strong) UIButton *faceBtn;
/** more按钮 */
@property (nonatomic, readonly, strong) UIButton *moreBtn;
/** 输入文本框 */
@property (nonatomic, readonly, strong) RFTextView *textView;
/** 按住录制语音按钮 */
@property (nonatomic, readonly, strong) RFRecordButton *recordBtn;

/** 默认为no */
@property (nonatomic, assign) BOOL allowSwitchBar;
/** 以下默认为yes*/
@property (nonatomic, assign) BOOL allowVoice;
@property (nonatomic, assign) BOOL allowFace;
@property (nonatomic, assign) BOOL allowMoreFunc;

@property (readonly) BOOL voiceSelected;
@property (readonly) BOOL faceSelected;
@property (readonly) BOOL moreFuncSelected;
@property (readonly) BOOL switchBarSelected;


- (void)setTextContent:(NSString *)text;
- (void)clearText;

/** 设置按钮图片 */
- (void)setBtn:(ButKind)btnKind normalStateImageStr:(NSString *)normalStr
selectStateImageStr:(NSString *)selectStr highLightStateImageStr:(NSString *)highLightStr;

@end
