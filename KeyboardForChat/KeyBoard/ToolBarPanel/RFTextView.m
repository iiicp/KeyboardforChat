//
//  RFTextView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/28.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "RFTextView.h"

@implementation RFTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:16.f];
        self.textColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1.0].CGColor;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth = 0.65f;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

#pragma mark -RFTextView 方法
- (NSUInteger)numberOfLinesOfText{
    return [RFTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)? 33:109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text{
    return (text.length / [RFTextView maxCharactersPerLine]) + 1;
}

@end