//
//  RFTextView.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFTextView : UITextView

@property (nonatomic, copy) NSString * placeHolder;

@property (nonatomic, strong) UIColor * placeHolderTextColor;

- (NSUInteger)numberOfLinesOfText;

@end
