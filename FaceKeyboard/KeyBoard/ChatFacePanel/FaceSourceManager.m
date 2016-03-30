//
//  FaceSourceManager.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceSourceManager.h"
#import "FaceSubjectModel.h"

@implementation FaceSourceManager

//从持久化存储里面加载表情源
+ (NSArray *)loadFaceSource
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
    NSDictionary *emojiDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *allkeys = emojiDic.allKeys;
    
    FaceSubjectModel *subjectFace = [[FaceSubjectModel alloc] init];
    subjectFace.faceSize = SubjectFaceSizeKindSmall;
    subjectFace.subjectName = @"emoji"; //可以是一张图片名
    
    NSMutableArray *modelsArr = [NSMutableArray array];
    
    for (NSString *name in allkeys) {
        FaceModel *fm = [[FaceModel alloc] init];
        fm.faceName = name;
        fm.facePicName = [emojiDic objectForKey:name];
        [modelsArr addObject:fm];
    }
    
    subjectFace.faceModels = [NSArray arrayWithArray:modelsArr];
    
    NSArray * faceSourceArray = @[subjectFace];
    
    return faceSourceArray;
}


@end
