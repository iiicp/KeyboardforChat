//
//  ToolbarView.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButKind)
{
    kButKindVoice,
    kButKindFace,
    kButKindMore,
    kButKindSwitchBarViewBtn
};

@interface ToolBarView : UIView

/** 切换barView按钮 */
@property (nonatomic, strong) UIButton *switchBarViewBtn;
/** 语音按钮 */
@property (nonatomic, strong) UIButton *voiceBtn;
/** 表情按钮 */
@property (nonatomic, strong) UIButton *faceBtn;
/** more按钮 */
@property (nonatomic, strong) UIButton *moreBtn;
/** 输入文本框 */
@property (nonatomic, strong) UITextView *textView;

/** 开关 */
@property (nonatomic, assign) BOOL haveSwitchBarViewBtn;
@property (nonatomic, assign) BOOL haveVoiceBtn;
@property (nonatomic, assign) BOOL haveFaceBtn;
@property (nonatomic, assign) BOOL haveMoreBtn;

/** 设置按钮图片 */
- (void)setBtn:(ButKind)btnKind normalStateImageStr:(NSString *)normalStr
selectStateImageStr:(NSString *)selectStr highLightStateImageStr:(NSString *)highLightStr;

@end
