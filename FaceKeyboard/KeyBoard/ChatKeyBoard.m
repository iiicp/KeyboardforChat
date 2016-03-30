//
//  ChatKeyBoard.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ChatKeyBoard.h"

#define K_ScreenW               [[UIScreen mainScreen] bounds].size.width
#define K_ScreenH               [[UIScreen mainScreen] bounds].size.height
#define ChatToolBarH            49
#define FaceViewH              216
#define MoreViewH              216
#define KeyBoardH              FaceViewH + ChatToolBarH

@interface ChatKeyBoard ()

@property (nonatomic, strong) ChatToolBar *chatToolBar;

@end

@implementation ChatKeyBoard

+ (instancetype)keyBoard
{
    return [[self alloc] initWithFrame:CGRectMake(0, K_ScreenH - ChatToolBarH, K_ScreenW, KeyBoardH)];
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
        self.chatToolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, 0, K_ScreenW, ChatToolBarH)];
        [self addSubview:self.chatToolBar];
        
        [self setToolBar];
        
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
        CGFloat ty = [[UIScreen mainScreen] bounds].size.height - rect.origin.y;
        self.transform = CGAffineTransformMakeTranslation(0, -ty);
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
    }
}

- (void)setToolBar
{
    [self.chatToolBar setBtn:kButKindFace normalStateImageStr:@"face_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
    [self.chatToolBar setBtn:kButKindVoice normalStateImageStr:@"voice_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
    [self.chatToolBar setBtn:kButKindMore normalStateImageStr:@"more_ios7" selectStateImageStr:nil highLightStateImageStr:nil];
    [self.chatToolBar setBtn:kButKindSwitchBarViewBtn normalStateImageStr:@"jobDownArrow" selectStateImageStr:@"upArrow"highLightStateImageStr:nil];
}

@end
