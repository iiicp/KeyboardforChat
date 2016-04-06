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
    SubjectFaceSizeKindBig          //... maybe 100
};

@interface FaceModel : NSObject

/** 表情标题 */
@property (nonatomic, copy) NSString *faceTitle;
/** 表情图片 */
@property (nonatomic, copy) NSString *faceIcon;

@end

@interface FaceSubjectModel : NSObject

@property (nonatomic, assign) SubjectFaceSizeKind faceSize;
@property (nonatomic, copy)   NSString *subjectIcon;
@property (nonatomic, copy)   NSString *subjectTitle;
@property (nonatomic, strong) NSArray *faceModels;

@end
