//
//  MiddleSizePageFaceView.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/31.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    负责展示中间尺寸的表情 ： 比如自定义gif，自己收藏的图片
 */

@interface MiddleSizePageFaceView : UICollectionViewCell

- (void)loadPerPageFaceData:(NSArray *)faceData;

@end
