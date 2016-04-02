//
//  ChatFacePanel.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//
//  2581502433@qq.com

/**
    尝试了 scroll + scroll
          collection + collection
    最终确定方案  scroll + collection
 */

#import "FacePanel.h"
#import "FaceView.h"
#import "PanelBottomView.h"
#import "FaceSourceManager.h"
#import "Macrol.h"

extern NSString * SmallSizeFacePanelfacePickedNotification;
extern NSString * MiddleSizeFacePanelfacePickedNotification;

@interface FacePanel () <UIScrollViewDelegate, PanelBottomViewDelegate>

@property (nonatomic, strong) NSArray *faceSources;

@end

@implementation FacePanel
{
    UIScrollView *_scrollView;
    PanelBottomView  *_panelBottomView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SmallSizeFacePanelfacePickedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MiddleSizeFacePanelfacePickedNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark -- 数据源
- (void)loadFaceSubjectItems:(NSArray<FaceSubjectModel *>*)subjectItems
{
    self.faceSources = subjectItems;
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.faceSources.count, 0);
    
    for (int i = 0; i < self.faceSources.count; i++) {
        FaceView *faceView = [[FaceView alloc] initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [faceView loadFaceSubject:self.faceSources[i]];
        [_scrollView addSubview:faceView];
    }
    
    [_panelBottomView loadfaceSubjectPickerSource:self.faceSources];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
    
        CGFloat pageWidth = scrollView.frame.size.width;
    
        NSInteger currentIndex = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
        [_panelBottomView changeFaceSubjectIndex:currentIndex];
    }
}

#pragma mark -- PanelBottomViewDelegate
- (void)panelBottomView:(PanelBottomView *)panelBottomView didPickerFaceSubjectIndex:(NSInteger)faceSubjectIndex
{
    [_scrollView setContentOffset:CGPointMake(faceSubjectIndex*self.frame.size.width, 0) animated:YES];
}

- (void)panelBottomViewSendAction:(PanelBottomView *)panelBottomView
{
    if ([self.delegate respondsToSelector:@selector(facePanelSendTextAction:)]) {
        [self.delegate facePanelSendTextAction:self];
    }
}

#pragma mark -- NSNotificationCenter
- (void)smallFaceClick:(NSNotification *)noti
{
    NSDictionary *info = [noti object];
    NSString *faceName = [info objectForKey:@"FaceName"];
    BOOL isDelete = [[info objectForKey:@"IsDelete"] boolValue];
    
    if ([self.delegate respondsToSelector:@selector(facePanelFacePicked:faceSize:faceName:delete:)]) {
        [self.delegate facePanelFacePicked:self faceSize:0 faceName:faceName delete:isDelete];
    }
}

- (void)middleFaceClick:(NSNotification *)noti
{
    NSString *faceName = [noti object];
    if ([self.delegate respondsToSelector:@selector(facePanelFacePicked:faceSize:faceName:delete:)]) {
        [self.delegate facePanelFacePicked:self faceSize:1 faceName:faceName delete:NO];
    }
}

- (void)initSubViews
{
    self.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0f];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kFacePanelHeight-kFacePanelBottomToolBarHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    _panelBottomView = [[PanelBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), self.frame.size.width, kFacePanelBottomToolBarHeight)];
    _panelBottomView.delegate = self;
    [self addSubview:_panelBottomView];
    
    
    __weak __typeof(self) weakSelf = self;
    _panelBottomView.addAction = ^(){
        if ([weakSelf.delegate respondsToSelector:@selector(facePanelAddSubject:)]) {
            [weakSelf.delegate facePanelAddSubject:weakSelf];
        }
    };
    
    _panelBottomView.setAction = ^(){
        if ([weakSelf.delegate respondsToSelector:@selector(facePanelSetSubject:)]) {
            [weakSelf.delegate facePanelSetSubject:weakSelf];
        }
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smallFaceClick:) name:SmallSizeFacePanelfacePickedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(middleFaceClick:) name:MiddleSizeFacePanelfacePickedNotification object:nil];
}


@end
