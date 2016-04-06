//
//  ChatFacePanel.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//


/**
 *  管理所有的表情主题
 */

#import <UIKit/UIKit.h>

@class FaceSubjectModel;
@class FacePanel;
@protocol FacePanelDelegate <NSObject>
@optional

- (void)facePanelFacePicked:(FacePanel *)facePanel faceSize:(NSInteger)faceSize faceName:(NSString *)faceName delete:(BOOL)isDelete;
- (void)facePanelSendTextAction:(FacePanel *)facePanel;
- (void)facePanelAddSubject:(FacePanel *)facePanel;
- (void)facePanelSetSubject:(FacePanel *)facePanel;

@end

@interface FacePanel : UIView

@property (nonatomic, weak) id<FacePanelDelegate> delegate;

- (void)loadFaceSubjectItems:(NSArray<FaceSubjectModel *>*)subjectItems;

@end
