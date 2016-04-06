//
//  OfficialAccountToolbar.h
//  KeyboardForChat

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/4/1.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SWITCHACTION) ();

@interface OfficialAccountToolbar : UIView

@property (nonatomic, copy) SWITCHACTION switchAction;

@end
