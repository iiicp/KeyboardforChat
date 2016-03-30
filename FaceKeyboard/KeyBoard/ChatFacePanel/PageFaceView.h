//
//  PageFaceView.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
    负责展示emoji类型的
 */
@interface PageFaceView : UICollectionViewCell

- (void)loadPerPageFaceData:(NSArray *)faceData;

@end
