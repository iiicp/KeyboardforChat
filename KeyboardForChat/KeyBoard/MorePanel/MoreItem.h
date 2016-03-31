//
//  MoreItem.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/31.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreItem : NSObject

@property (nonatomic, copy) NSString * itemPicName;
@property (nonatomic, copy) NSString * itemHighlightPicName;
@property (nonatomic, copy) NSString * itemName;

+ (instancetype)moreItemWithPicName:(NSString *)picName highLightPicName:(NSString *)highLightPicName itemName:(NSString *)itemName;

@end
