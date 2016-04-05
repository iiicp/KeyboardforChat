//
//  PageFaceView.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "SmallSizePageFaceView.h"
#import "FaceSubjectModel.h"
#import "FaceButton.h"
#import "Macrol.h"

#define FaceContainerHeight       kFacePanelHeight - kFacePanelBottomToolBarHeight - kUIPageControllerHeight //146
#define Item                        40.f
#define EdgeDistance                10.f
#define Lines                       3

NSString *const SmallSizeFacePanelfacePickedNotification = @"SmallSizeFacePanelfacePickedNotification";

@interface  SmallSizePageFaceView ()
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation SmallSizePageFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSInteger cols = 7;
        if (isIPhone4_5) {cols = 7;}else if (isIPhone6_6s) {cols = 8;}else if (isIPhone6p_6sp){cols = 9;}

        CGFloat vMargin = (FaceContainerHeight - Lines * Item) / (Lines+1);
        CGFloat hMargin = (CGRectGetWidth(self.bounds) - cols * Item - 2*EdgeDistance) / cols;

        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < Lines; ++i) {
            for (int j = 0; j < cols; ++j) {
                FaceButton *btn = [FaceButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*Item+EdgeDistance+j*hMargin,i*Item+(i+1)*vMargin,Item,Item);
                [btn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                [array addObject:btn];
            }
        }
        self.buttons = array;
    }
    return self;
}

- (void)loadPerPageFaceData:(NSArray *)faceData;
{
    for (int i = 0; i < faceData.count; i++) {
        FaceModel *fm = faceData[i];
        FaceButton *btn = self.buttons[i];
        btn.hidden = NO;
        [btn setImage:[UIImage imageNamed:fm.facePicName] forState:UIControlStateNormal];
        btn.faceName = fm.faceName;
    }
    FaceButton *btn =self.buttons[faceData.count];
    btn.hidden = NO;
    [btn setImage:[UIImage imageNamed:@"Delete_ios7"] forState:UIControlStateNormal];
    btn.faceName = nil;
    
    for (NSInteger i = faceData.count+1; i < self.buttons.count; ++i) {
        FaceButton *btn = self.buttons[i];
        btn.hidden = YES;
        [btn setImage:nil forState:UIControlStateNormal];
    }
}

- (void)faceBtnClick:(FaceButton *)button
{
    NSLog(@"name %@", button.faceName);
    BOOL isDelete = NO;
    if (button.faceName == nil) {
        isDelete = YES;
    }else {
        button.faceName = @"";
    }
    NSDictionary *faceInfo = @{
                               @"FaceName" : button.faceName,
                               @"IsDelete" : @(isDelete)
                               };
    [[NSNotificationCenter defaultCenter] postNotificationName:SmallSizeFacePanelfacePickedNotification object:faceInfo];
}

@end
