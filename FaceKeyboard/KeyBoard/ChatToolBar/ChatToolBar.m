//
//  ToolbarView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ChatToolBar.h"

#define Image(str)  (str == nil || str.length == 0) ? nil : [UIImage imageNamed:str]
#define ItemW       49
#define ItemH       49
#define TextViewH   36
#define TextViewVerticalOffset  (ItemH-TextViewH)/2.0
#define ScreenW [[UIScreen mainScreen] bounds].size.width
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface ChatToolBar ()<UITextViewDelegate>

@property CGFloat previousTextViewHeight;
@property(readwrite) BOOL isInputting;

/** 切换barView按钮 */
@property (nonatomic, strong) UIButton *switchBarViewBtn;
/** 语音按钮 */
@property (nonatomic, strong) UIButton *voiceBtn;
/** 表情按钮 */
@property (nonatomic, strong) UIButton *faceBtn;
/** more按钮 */
@property (nonatomic, strong) UIButton *moreBtn;
/** 输入文本框 */
@property (nonatomic, strong) RFTextView *textView;
/** 按住录制语音按钮 */
@property (nonatomic, strong) RFRecordButton *recordBtn;

@end

@implementation ChatToolBar

#pragma mark -- dealloc

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"self.textView.contentSize"];
}

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

- (void)setDefaultValue
{
    self.haveSwitchBarViewBtn = NO;
    self.haveVoiceBtn = YES;
    self.haveFaceBtn = YES;
    self.haveMoreBtn = YES;
}

- (void)setup
{
    // barView
    self.image = [[UIImage imageNamed:@"input-bar-flat"] resizableImageWithCapInsets:UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, 0.0f) resizingMode:UIImageResizingModeStretch];
    self.userInteractionEnabled = YES;
    self.previousTextViewHeight = TextViewH;
    
    // addSubView
    self.switchBarViewBtn = [self createBtn:kButKindSwitchBarViewBtn action:@selector(toolbarBtnClick:)];
    self.switchBarViewBtn.hidden = YES;
    self.voiceBtn = [self createBtn:kButKindVoice action:@selector(toolbarBtnClick:)];
    self.faceBtn = [self createBtn:kButKindFace action:@selector(toolbarBtnClick:)];
    self.moreBtn = [self createBtn:kButKindMore action:@selector(toolbarBtnClick:)];
    self.recordBtn = [[RFRecordButton alloc] init];
    
    self.textView = [[RFTextView alloc] init];
    self.textView.frame = CGRectMake(0, 0, 0, TextViewH);
    self.textView.delegate = self;
    
    [self addSubview:self.voiceBtn];
    [self addSubview:self.faceBtn];
    [self addSubview:self.moreBtn];
    [self addSubview:self.switchBarViewBtn];
    [self addSubview:self.textView];
    [self addSubview:self.recordBtn];
    
    //设置frame
    [self setbarSubViewsFrame];
    
    //事件
    [self addObserver:self forKeyPath:@"self.textView.contentSize" options:(NSKeyValueObservingOptionNew) context:nil];
   
    __weak __typeof(self) weekSelf = self;
    self.recordBtn.recordTouchDownAction = ^(RFRecordButton *sender){
        NSLog(@"开始录音");
        if (sender.highlighted) {
            sender.highlighted = YES;
            [sender setButtonStateWithRecording];
        }
        if ([weekSelf.delegate respondsToSelector:@selector(chatToolBarDidStartRecording:)]) {
            [weekSelf.delegate chatToolBarDidStartRecording:weekSelf];
        }
    };
    self.recordBtn.recordTouchUpInsideAction = ^(RFRecordButton *sender){
        NSLog(@"完成录音");
        [sender setButtonStateWithNormal];
        if ([weekSelf.delegate respondsToSelector:@selector(chatToolBarDidFinishRecoding:)]) {
            [weekSelf.delegate chatToolBarDidFinishRecoding:weekSelf];
        }
    };
    self.recordBtn.recordTouchUpOutsideAction = ^(RFRecordButton *sender){
        NSLog(@"取消录音");
        [sender setButtonStateWithNormal];
        if ([weekSelf.delegate respondsToSelector:@selector(chatToolBarDidCancelRecording:)]) {
            [weekSelf.delegate chatToolBarDidCancelRecording:weekSelf];
        }
    };
    
    //持续调用
    self.recordBtn.recordTouchDragInsideAction = ^(RFRecordButton *sender){
    };
    //持续调用
    self.recordBtn.recordTouchDragOutsideAction = ^(RFRecordButton *sender){
    };
    
    //中间状态  从 TouchDragInside ---> TouchDragOutside
    self.recordBtn.recordTouchDragExitAction = ^(RFRecordButton *sender){
        NSLog(@"将要取消录音");
        if ([weekSelf.delegate respondsToSelector:@selector(chatToolBarWillCancelRecoding:)]) {
            [weekSelf.delegate chatToolBarWillCancelRecoding:weekSelf];
        }
    };
    //中间状态  从 TouchDragOutside ---> TouchDragInside
    self.recordBtn.recordTouchDragEnterAction = ^(RFRecordButton *sender){
        NSLog(@"继续录音");
        if ([weekSelf.delegate respondsToSelector:@selector(chatToolBarContineRecording:)]) {
            [weekSelf.delegate chatToolBarContineRecording:weekSelf];
        }
    };
}

- (void)setbarSubViewsFrame
{
    CGFloat barViewH = self.frame.size.height;
    
    if (self.haveSwitchBarViewBtn) {
        self.switchBarViewBtn.frame = CGRectMake(0, barViewH - ItemH, ItemW, ItemH);
    }else {
        self.switchBarViewBtn.frame = CGRectZero;
    }
    
    if (self.haveVoiceBtn){
        self.voiceBtn.frame = CGRectMake(CGRectGetMaxX(self.switchBarViewBtn.frame), barViewH - ItemH, ItemW, ItemH);
    }else {
        self.voiceBtn.frame = CGRectZero;
    }
    
    if (self.haveMoreBtn) {
        self.moreBtn.frame = CGRectMake(self.frame.size.width - ItemW, barViewH - ItemH, ItemW, ItemH);
    }else {
        self.moreBtn.frame = CGRectZero;
    }
    
    if (self.haveFaceBtn){
        self.faceBtn.frame = CGRectMake(self.frame.size.width - ItemW - CGRectGetWidth(self.moreBtn.frame), barViewH - ItemH, ItemW, ItemH);
    }else {
        self.faceBtn.frame = CGRectZero;
    }
    
    self.textView.frame = CGRectMake(CGRectGetWidth(self.switchBarViewBtn.frame) + CGRectGetWidth(self.voiceBtn.frame), TextViewVerticalOffset, self.frame.size.width-CGRectGetWidth(self.switchBarViewBtn.frame)-CGRectGetWidth(self.voiceBtn.frame)-CGRectGetWidth(self.faceBtn.frame)-CGRectGetWidth(self.moreBtn.frame), self.textView.frame.size.height);
    
    self.recordBtn.frame = self.textView.frame;
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

- (UIButton *)createBtn:(ButKind)btnKind action:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    switch (btnKind) {
        case kButKindVoice:
            btn.tag = 1;
            break;
        case kButKindFace:
            btn.tag = 2;
            break;
        case kButKindMore:
            btn.tag = 3;
            break;
        case kButKindSwitchBarViewBtn:
            btn.tag = 4;
            break;
        default:
            break;
    }
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    return btn;
}

#pragma mark -- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.voiceBtn.selected = NO;
    self.faceBtn.selected = NO;
    self.moreBtn.selected = NO;
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.isInputting = YES;
    if ([self.delegate respondsToSelector:@selector(chatToolBarTextViewDidBeginEditing:)]) {
        [self.delegate chatToolBarTextViewDidBeginEditing:self.textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(chatToolBarSendText:)]) {
            [self.delegate chatToolBarSendText:text];
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"self.textview.content %@", NSStringFromCGSize(textView.contentSize));
    if ([self.delegate respondsToSelector:@selector(chatToolBarTextViewDidChange:)]) {
        [self.delegate chatToolBarTextViewDidChange:self.textView];
    }
}

#pragma mark - kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"self.textView.contentSize"]) {
        [self layoutAndAnimateTextView:self.textView];
    }
}

#pragma mark -- 事件
- (void)toolbarBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            self.voiceBtn.selected = !self.voiceBtn.selected;
            self.faceBtn.selected = NO;
            self.moreBtn.selected = NO;
            
            if (sender.selected) {
                [self.textView resignFirstResponder];
                self.isInputting = NO;
            }else {
                [self.textView becomeFirstResponder];
                self.isInputting = YES;
            }
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.recordBtn.hidden = !sender.selected;
                self.textView.hidden = sender.selected;
            } completion:nil];
            
            if ([self.delegate respondsToSelector:@selector(chatToolBar:voiceBtnPressed:)]) {
                [self.delegate chatToolBar:self voiceBtnPressed:sender.selected];
            }
            
            break;
        }
        case 2:
        {
            self.faceBtn.selected = !self.faceBtn.selected;
            self.voiceBtn.selected = NO;
            self.moreBtn.selected = NO;
            
            if (sender.selected) {
                [self.textView resignFirstResponder];
            }else {
                [self.textView becomeFirstResponder];
            }
            self.isInputting = YES;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.recordBtn.hidden = YES;
                self.textView.hidden = NO;
            } completion:nil];
            
            if ([self.delegate respondsToSelector:@selector(chatToolBar:faceBtnPressed:)]) {
                [self.delegate chatToolBar:self faceBtnPressed:sender.selected];
            }
            
            break;
        }
        case 3:
        {
            self.moreBtn.selected = !self.moreBtn.selected;
            self.voiceBtn.selected = NO;
            self.faceBtn.selected = NO;
            
            if (sender.selected) {
                [self.textView resignFirstResponder];
            }else {
                [self.textView becomeFirstResponder];
            }
            self.isInputting = YES;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.recordBtn.hidden = YES;
                self.textView.hidden = NO;
            } completion:nil];
            
            if ([self.delegate respondsToSelector:@selector(chatToolBar:moreBtnPressed:)]) {
                [self.delegate chatToolBar:self moreBtnPressed:sender.selected];
            }
            
            break;
        }
        case 4:
            NSLog(@"切换barview");
            if (sender.selected) {
                [self.textView resignFirstResponder];
            }
            self.switchBarViewBtn.selected = !self.switchBarViewBtn.selected;
            if ([self.delegate respondsToSelector:@selector(chatToolBar:switchToolBarBtnPressed:)]) {
                [self.delegate chatToolBar:self switchToolBarBtnPressed:sender.selected];
            }
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
    [self setbarSubViewsFrame];
}

- (void)setHaveVoiceBtn:(BOOL)haveVoiceBtn
{
    _haveVoiceBtn = haveVoiceBtn;
    
    if (_haveVoiceBtn) {
        self.voiceBtn.hidden = NO;
    }else {
        self.voiceBtn.hidden = YES;
    }
    
    [self setbarSubViewsFrame];
}

- (void)setHaveFaceBtn:(BOOL)haveFaceBtn
{
    _haveFaceBtn = haveFaceBtn;
    
    if (_haveFaceBtn) {
        self.faceBtn.hidden = NO;
    }else {
        self.faceBtn.hidden = YES;
    }
    
    [self setbarSubViewsFrame];
}

- (void)setHaveMoreBtn:(BOOL)haveMoreBtn
{
    _haveMoreBtn = haveMoreBtn;
    if (_haveMoreBtn) {
        self.moreBtn.hidden = NO;
    }else {
        self.moreBtn.hidden = YES;
    }
    
    [self setbarSubViewsFrame];
}

#pragma mark -- 私有方法
- (CGFloat)getTextViewContentH:(RFTextView *)textView {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

- (CGFloat)fontWidth
{
    return 36.f; //16号字体
}

- (CGFloat)maxLines
{
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat line = 5;
    if (h == 480) {
        line = 3;
    }else if (h == 568){
        line = 3.5;
    }else if (h == 667){
        line = 4;
    }else if (h == 736){
        line = 4.5;
    }
    return line;
}

- (void)layoutAndAnimateTextView:(RFTextView *)textView
{
    CGFloat maxHeight = [self fontWidth] * [self maxLines];
    CGFloat contentH = [self getTextViewContentH:textView];
    
    BOOL isShrinking = contentH < self.previousTextViewHeight;
    CGFloat changeInHeight = contentH - self.previousTextViewHeight;
    
    if (!isShrinking && (self.previousTextViewHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewHeight);
    }
    
    if (changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             if (isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewHeight = MIN(contentH, maxHeight);
                                 }
                                 // if shrinking the view, animate text view frame BEFORE input view frame
                                 [self adjustTextViewHeightBy:changeInHeight];
                             }
                             CGRect inputViewFrame = self.frame;
                             self.frame = CGRectMake(0.0f,
                                                    0, //inputViewFrame.origin.y - changeInHeight
                                                    inputViewFrame.size.width,
                                                     (inputViewFrame.size.height + changeInHeight));
                             if (!isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewHeight = MIN(contentH, maxHeight);
                                 }
                                 // growing the view, animate the text view frame AFTER input view frame
                                 [self adjustTextViewHeightBy:changeInHeight];
                             }
                         }
                         completion:^(BOOL finished) {
                         }];
        self.previousTextViewHeight = MIN(contentH, maxHeight);
    }
    
    // Once we reached the max height, we have to consider the bottom offset for the text view.
    // To make visible the last line, again we have to set the content offset.
    if (self.previousTextViewHeight == maxHeight) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,
                       dispatch_get_main_queue(),
                       ^(void) {
                           CGPoint bottomOffset = CGPointMake(0.0f, contentH - textView.bounds.size.height);
                           [textView setContentOffset:bottomOffset animated:YES];
                       });
    }
}

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight
{
    //动态改变自身的高度和输入框的高度
    CGRect prevFrame = self.textView.frame;
    
    NSUInteger numLines = MAX([self.textView numberOfLinesOfText],
                              [[self.textView.text componentsSeparatedByString:@"\n"] count] + 1);
    
    
    self.textView.frame = CGRectMake(prevFrame.origin.x, prevFrame.origin.y, prevFrame.size.width, prevFrame.size.height + changeInHeight);
    
    self.textView.contentInset = UIEdgeInsetsMake((numLines >=6 ? 4.0f : 0.0f), 0.0f, (numLines >=6 ? 4.0f : 0.0f), 0.0f);
    
    // from iOS 7, the content size will be accurate only if the scrolling is enabled.
    //self.messageInputTextView.scrollEnabled = YES;
    if (numLines >=6) {
        CGPoint bottomOffset = CGPointMake(0.0f, self.textView.contentSize.height-self.textView.bounds.size.height);
        [self.textView setContentOffset:bottomOffset animated:YES];
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length-2, 1)];
    }
}


@end
