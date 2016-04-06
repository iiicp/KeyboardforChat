//
//  FaceView.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceView.h"
#import "SmallSizePageFaceView.h"
#import "MiddleSizePageFaceView.h"
#import "FaceSubjectModel.h"
#import "ChatKeyBoardMacrolDefine.h"

NSString *const SmallSizePageFaceViewIdentifier = @"SmallSizePageFaceViewIdentifier";
NSString *const MiddleSizePageFaceViewIdentifier = @"MiddleSizePageFaceViewIdentifier";

@interface FaceView () <UICollectionViewDataSource, UICollectionViewDelegate>

/** 表情主题 */
@property (nonatomic, strong) FaceSubjectModel *subjectModel;
@property (nonatomic, strong) NSArray *pageFaceArray;

@end

@implementation FaceView
{
    UICollectionView *_collectionView;
    UIPageControl    * _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageFaceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_subjectModel.faceSize == SubjectFaceSizeKindSmall)
    {
        SmallSizePageFaceView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SmallSizePageFaceViewIdentifier forIndexPath:indexPath];
        [cell loadPerPageFaceData:self.pageFaceArray[indexPath.row]];
        
        NSLog(@"indexPath %zd", indexPath.row);
     
        return cell;
    }
    else if (_subjectModel.faceSize == SubjectFaceSizeKindMiddle)
    {
        MiddleSizePageFaceView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MiddleSizePageFaceViewIdentifier forIndexPath:indexPath];
        [cell loadPerPageFaceData:self.pageFaceArray[indexPath.row]];
         NSLog(@"indexPath %zd", indexPath.row);
        return cell;
    }
    else if (_subjectModel.faceSize == SubjectFaceSizeKindKindBig) {
        return nil;
    }
    return [[UICollectionViewCell alloc] init];
}

#pragma mark -- UIScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        //每页宽度
        CGFloat pageWidth = scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
        [_pageControl setCurrentPage:currentPage];
    }
}

//加载表情主题
- (void)loadFaceSubject:(FaceSubjectModel *)faceSubject;
{
    _subjectModel = faceSubject;
    
    NSInteger numbersOfPerPage = [self numbersOfPerPage:faceSubject];
    
    NSMutableArray *pagesArray = [NSMutableArray array];
    NSInteger counts = faceSubject.faceModels.count;
    
    NSMutableArray *page = nil;
    for (int i = 0; i < counts; ++i) {
        if (i % numbersOfPerPage == 0) {
            page = [NSMutableArray array];
            [pagesArray addObject:page];
        }
        [page addObject:faceSubject.faceModels[i]];
    }
    self.pageFaceArray = [NSArray arrayWithArray:pagesArray];
    _pageControl.numberOfPages = self.pageFaceArray.count;
}


- (NSInteger)numbersOfPerPage:(FaceSubjectModel *)faceSubject
{
    NSInteger perPageNum = 0;
    
    if (faceSubject.faceSize == SubjectFaceSizeKindSmall)
    {
        NSInteger colNumber = 7;
        if (isIPhone4_5)
            colNumber = 7;
        else if (isIPhone6_6s)
            colNumber = 8;
        else if (isIPhone6p_6sp)
            colNumber = 9;
        perPageNum = colNumber * 3 - 1; //最后一个是删除符
    }
    else if (faceSubject.faceSize == SubjectFaceSizeKindMiddle)
    {
        perPageNum = 4 * 2;
    }
    else
    {
        perPageNum = 4 * 2;
    }
    return perPageNum;
}

- (void)initSubViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //这个 item 表示cell的大小
    flowLayout.itemSize = self.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [_collectionView registerClass:[SmallSizePageFaceView class] forCellWithReuseIdentifier:SmallSizePageFaceViewIdentifier];
    [_collectionView registerClass:[MiddleSizePageFaceView class] forCellWithReuseIdentifier:MiddleSizePageFaceViewIdentifier];
    
    [self addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-kUIPageControllerHeight, self.frame.size.width, kUIPageControllerHeight)];
    _pageControl.currentPage = 0;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageControl];
}


@end
