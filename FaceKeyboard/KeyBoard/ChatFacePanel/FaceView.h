//
//  FaceView.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceSubjectModel;

@interface FaceView : UICollectionViewCell

- (void)loadFaceSubject:(FaceSubjectModel *)faceSubject;

@end
