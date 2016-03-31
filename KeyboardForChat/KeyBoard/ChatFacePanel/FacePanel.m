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

@interface FacePanel () <UIScrollViewDelegate, PanelBottomViewDelegate>

@property (nonatomic, strong) NSArray *faceSources;

@end

@implementation FacePanel
{
    UIScrollView *_scrollView;
    PanelBottomView  *_panelBottomView;
}


+ (instancetype)facePanel
{
     return [[self alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-216, [[UIScreen mainScreen] bounds].size.width, 216)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
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

- (void)initSubViews
{
    self.faceSources = [FaceSourceManager loadFaceSource];
    
    self.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0f];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kFacePanelHeight-kFacePanelBottomToolBarHeight)];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.faceSources.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    for (int i = 0; i < self.faceSources.count; i++) {
        FaceView *faceView = [[FaceView alloc] initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [faceView loadFaceSubject:self.faceSources[i]];
        [_scrollView addSubview:faceView];
    }
    
    _panelBottomView = [[PanelBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), self.frame.size.width, kFacePanelBottomToolBarHeight)];
    _panelBottomView.delegate = self;
    [_panelBottomView loadfaceSubjectPickerSource:self.faceSources];
    [self addSubview:_panelBottomView];
    
    
    _panelBottomView.addAction = ^(){
        NSLog(@"add动作");
    };
    
    _panelBottomView.setAction = ^(){
        NSLog(@"set动作");
    };
}


@end
