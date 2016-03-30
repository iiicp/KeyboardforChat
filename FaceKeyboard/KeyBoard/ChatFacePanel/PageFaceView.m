//
//  PageFaceView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "PageFaceView.h"
#import "FaceSubjectModel.h"
#import "FaceButton.h"

#define PageFaceH       146.f
#define Item            40.f
#define EdgeDistance    10.f
#define Lines           3

@interface  PageFaceView ()
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation PageFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat w =self.frame.size.width;
        NSInteger cols = 7;
        if (w == 320) {cols = 7;}else if (w == 375) {cols = 8;}else if (w == 414){cols = 9;}

        CGFloat vMargin = (PageFaceH - Lines * Item) / (Lines+1);
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
        btn.emojiName = fm.faceName;
    }
    FaceButton *btn =self.buttons[faceData.count];
    btn.hidden = NO;
    [btn setImage:[UIImage imageNamed:@"Delete_ios7"] forState:UIControlStateNormal];
    btn.emojiName = nil;
    
    for (NSInteger i = faceData.count+1; i < self.buttons.count; ++i) {
        FaceButton *btn = self.buttons[i];
        btn.hidden = YES;
        [btn setImage:nil forState:UIControlStateNormal];
    }
}

- (void)faceBtnClick:(FaceButton *)button
{
    NSLog(@"name %@", button.emojiName);
}

@end
