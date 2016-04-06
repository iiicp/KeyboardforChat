//
//  PageFaceView.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
    负责小尺寸的表情图片展示 比如：展示emoji类型的
 */
@interface SmallSizePageFaceView : UICollectionViewCell

- (void)loadPerPageFaceData:(NSArray *)faceData;

@end
