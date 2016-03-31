//
//  ChatKeyBoard.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatToolBar.h"
#import "FacePanel.h"
#import "MorePanel.h"

@interface ChatKeyBoard : UIView

@property (nonatomic, readonly, strong) ChatToolBar *chatToolBar;
@property (nonatomic, readonly, strong) FacePanel *facePanel;
@property (nonatomic, readonly, strong) MorePanel *morePanel;

+ (instancetype)keyBoard;

@end
