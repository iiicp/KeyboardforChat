//
//  ToolbarView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ToolBarView.h"

#define Image(str)  (str == nil || str.length == 0) ? nil : [UIImage imageNamed:str]
#define ItemW   40
#define ItemH   40
#define ScreenW [[UIScreen mainScreen] bounds].size.width
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@implementation ToolBarView

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValue];
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultValue];
        [self setup];
    }
    return self;
}

- (void)setDefaultValue
{
    self.haveSwitchBarViewBtn = NO;
    self.haveVoiceBtn = YES;
    self.haveFaceBtn = YES;
    self.haveMoreBtn = YES;
}

- (void)setup
{
    self.switchBarViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.textView = [[UITextView alloc] init];
    
    self.voiceBtn.tag = 1;
    self.faceBtn.tag = 2;
    self.moreBtn.tag = 3;
    self.switchBarViewBtn.tag = 4;
    
    [self.voiceBtn addTarget:self action:@selector(toolbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.faceBtn addTarget:self action:@selector(toolbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreBtn addTarget:self action:@selector(toolbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchBarViewBtn addTarget:self action:@selector(toolbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.voiceBtn];
    [self addSubview:self.faceBtn];
    [self addSubview:self.moreBtn];
    [self addSubview:self.switchBarViewBtn];
    
    [self addSubview:self.textView];
    
    self.voiceBtn.backgroundColor = kRandomColor;
    self.faceBtn.backgroundColor = kRandomColor;
    self.moreBtn.backgroundColor = kRandomColor;
    self.textView.backgroundColor = kRandomColor;
    
    self.switchBarViewBtn.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.haveSwitchBarViewBtn) {
        self.switchBarViewBtn.frame = CGRectMake(0, 0, ItemW, ItemH);
    }else {
        self.switchBarViewBtn.frame = CGRectZero;
    }
    
    if (self.haveVoiceBtn){
        self.voiceBtn.frame = CGRectMake(CGRectGetMaxX(self.switchBarViewBtn.frame), 0, ItemW, ItemH);
    }else {
        self.voiceBtn.frame = CGRectZero;
    }
    
    if (self.haveMoreBtn) {
        self.moreBtn.frame = CGRectMake(self.frame.size.width - ItemW, 0, ItemW, ItemH);
    }else {
        self.moreBtn.frame = CGRectZero;
    }
    
    if (self.haveFaceBtn){
        self.faceBtn.frame = CGRectMake(self.frame.size.width - ItemW - CGRectGetWidth(self.moreBtn.frame), 0, ItemW, ItemH);
    }else {
        self.faceBtn.frame = CGRectZero;
    }
    
    self.textView.frame = CGRectMake(CGRectGetWidth(self.switchBarViewBtn.frame) + CGRectGetWidth(self.voiceBtn.frame), 0, self.frame.size.width-CGRectGetWidth(self.switchBarViewBtn.frame)-CGRectGetWidth(self.voiceBtn.frame)-CGRectGetWidth(self.faceBtn.frame)-CGRectGetWidth(self.moreBtn.frame), ItemH);
}

#pragma mark -- 方法
- (void)setBtn:(ButKind)btnKind normalStateImageStr:(NSString *)normalStr
selectStateImageStr:(NSString *)selectStr highLightStateImageStr:(NSString *)highLightStr
{
    UIButton *btn;
    
    switch (btnKind) {
        case kButKindFace:
            btn = self.faceBtn;
            break;
        case kButKindMore:
            btn = self.moreBtn;
            break;
        case kButKindVoice:
            btn = self.voiceBtn;
            break;
        case kButKindSwitchBarViewBtn:
            btn = self.switchBarViewBtn;
            break;
        default:
            break;
    }
    [btn setImage:Image(normalStr) forState:UIControlStateNormal];
    [btn setImage:Image(selectStr) forState:UIControlStateSelected];
    [btn setImage:Image(highLightStr) forState:UIControlStateHighlighted];
}

#pragma mark -- 事件
- (void)toolbarBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
            NSLog(@"语音");
            self.voiceBtn.selected = !self.voiceBtn.selected;
            break;
        case 2:
            NSLog(@"表情");
            self.faceBtn.selected = !self.faceBtn.selected;
            break;
        case 3:
            NSLog(@"更多");
            self.moreBtn.selected = !self.moreBtn.selected;
            break;
        case 4:
            NSLog(@"切换barview");
            break;
        default:
            break;
    }
}

#pragma mark -- 重写set方法
- (void)setHaveSwitchBarViewBtn:(BOOL)haveSwitchBarViewBtn
{
    _haveSwitchBarViewBtn = haveSwitchBarViewBtn;
    
    if (_haveSwitchBarViewBtn) {
        self.switchBarViewBtn.hidden = NO;
    }else {
        self.switchBarViewBtn.hidden = YES;
    }
    
    [self setNeedsLayout];
}

- (void)setHaveVoiceBtn:(BOOL)haveVoiceBtn
{
    _haveVoiceBtn = haveVoiceBtn;
    
    if (_haveVoiceBtn) {
        self.voiceBtn.hidden = NO;
    }else {
        self.voiceBtn.hidden = YES;
    }
    
    [self setNeedsLayout];
}

- (void)setHaveFaceBtn:(BOOL)haveFaceBtn
{
    _haveFaceBtn = haveFaceBtn;
    
    if (_haveFaceBtn) {
        self.faceBtn.hidden = NO;
    }else {
        self.faceBtn.hidden = YES;
    }
    
    [self setNeedsLayout];
}

- (void)setHaveMoreBtn:(BOOL)haveMoreBtn
{
    _haveMoreBtn = haveMoreBtn;
    if (_haveMoreBtn) {
        self.moreBtn.hidden = NO;
    }else {
        self.moreBtn.hidden = YES;
    }
    
    [self setNeedsLayout];
}

@end
