//
//  ChatKeyBoard.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatToolBar.h"

@interface ChatKeyBoard : UIView

@property (nonatomic, readonly) ChatToolBar *chatToolBar;

+ (instancetype)keyBoard;

@end
