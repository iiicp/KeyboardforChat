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
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face", @"emotion",@"face",@"emotion",@"emotion",@"face",@"face",@"emotion",@"face", @"emotion",@"face", @"emotion"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceSubjectModel *subjectM = [[FaceSubjectModel alloc] init];
        
        if ([plistName isEqualToString:@"face"]) {
            subjectM.faceSize = SubjectFaceSizeKindSmall;
        }else {
            subjectM.faceSize = SubjectFaceSizeKindMiddle;
        }
        
        //可以自己配置成图片名
        subjectM.subjectName = [NSString stringWithFormat:@"f%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (NSString *name in allkeys) {
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceName = name;
            fm.facePicName = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        subjectM.faceModels = modelsArr;
        
        [subjectArray addObject:subjectM];
    }
    
    
    return subjectArray;
}


@end
