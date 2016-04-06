//
//  FaceView.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceSubjectModel;

/**
 *  负责展示，每一个表情主题
 */

@interface FaceView : UIView

- (void)loadFaceSubject:(FaceSubjectModel *)faceSubject;

@end
