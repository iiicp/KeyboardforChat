//
//  ChatKeyBoard.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ChatKeyBoard.h"

@interface ChatKeyBoard ()


@end

@implementation ChatKeyBoard

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.chatToolBar = [[ChatToolBar alloc] initWithFrame:self.bounds];
        [self addSubview:self.chatToolBar];
        
        [self.chatToolBar setBtn:kButKindFace normalStateImageStr:@"face_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
        [self.chatToolBar setBtn:kButKindVoice normalStateImageStr:@"voice_ios7" selectStateImageStr:@"keyboard_ios7" highLightStateImageStr:nil];
        [self.chatToolBar setBtn:kButKindMore normalStateImageStr:@"more_ios7" selectStateImageStr:nil highLightStateImageStr:nil];
        [self.chatToolBar setBtn:kButKindSwitchBarViewBtn normalStateImageStr:@"jobDownArrow" selectStateImageStr:@"upArrow"highLightStateImageStr:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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

@end
