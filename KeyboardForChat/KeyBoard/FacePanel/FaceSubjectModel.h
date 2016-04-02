//
//  FaceModel.h
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SubjectFaceSizeKind)
{
    SubjectFaceSizeKindSmall,       //40
    SubjectFaceSizeKindMiddle,      //60
    SubjectFaceSizeKindKindBig      //...
};

@interface FaceModel : NSObject

/** 表情名字 */
@property (nonatomic, copy) NSString *faceName;
/** 表情图片名字 */
@property (nonatomic, copy) NSString *facePicName;

@end

@interface FaceSubjectModel : NSObject

@property (nonatomic, assign) SubjectFaceSizeKind faceSize;
@property (nonatomic, copy)   NSString *subjectName;
@property (nonatomic, strong) NSArray *faceModels;

@end
