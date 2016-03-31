//
//  MiddleSizePageFaceView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/31.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "MiddleSizePageFaceView.h"
#import "FaceSubjectModel.h"
#import "FaceButton.h"
#import "Macrol.h"

#define FaceContainerHeight       kFacePanelHeight - kFacePanelBottomToolBarHeight - kUIPageControllerHeight //146
#define Item                        60.f
#define Lines                       2
#define Cols                        4

@interface MiddleSizePageFaceView ()
/** buttons容器数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation MiddleSizePageFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat vMargin = (FaceContainerHeight - Lines * Item) / (Lines+1);
        CGFloat hMargin = (kScreenWidth - Cols * Item) / (Cols+1);
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < Lines; ++i) {
            for (int j = 0; j < Cols; ++j) {
                FaceButton *btn = [FaceButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*Item+(j+1)*hMargin,i*Item+(i+1)*vMargin,Item,Item);
                [btn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                [array addObject:btn];
            }
        }
        self.buttons = array;
    }
    return self;
}

- (void)loadPerPageFaceData:(NSArray *)faceData
{
    for (int i = 0; i < faceData.count; i++) {
        FaceModel *fm = faceData[i];
        FaceButton *btn = self.buttons[i];
        btn.hidden = NO;
        [btn setImage:[UIImage imageNamed:fm.facePicName] forState:UIControlStateNormal];
        btn.faceName = fm.facePicName;
    }
    
    for (NSInteger i = faceData.count; i < self.buttons.count; ++i) {
        FaceButton *btn = self.buttons[i];
        btn.hidden = YES;
        [btn setImage:nil forState:UIControlStateNormal];
    }
}

- (void)faceBtnClick:(FaceButton *)sender
{
    NSLog(@"点击的图片 %@", sender.faceName);
}

@end
