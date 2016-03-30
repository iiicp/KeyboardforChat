//
//  FaceView.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceView.h"
#import "PageFaceView.h"
#import "FaceSubjectModel.h"

NSString *const PageFaceViewIdentifier = @"pageFaceViewIdentifier";

@interface FaceView () <UICollectionViewDataSource, UICollectionViewDelegate>

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
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //这个 item 表示cell的大小
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[PageFaceView class] forCellWithReuseIdentifier:PageFaceViewIdentifier];
        [self addSubview:_collectionView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        [self addSubview:_pageControl];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageFaceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageFaceView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PageFaceViewIdentifier forIndexPath:indexPath];
    [cell loadPerPageFaceData:self.pageFaceArray[indexPath.row]];
    return cell;
}

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
    NSInteger colNumber = [self colNumber:faceSubject];
    NSInteger lineNumber = [self lineNumber:faceSubject];
    
    NSMutableArray *pagesArray = [NSMutableArray array];
    NSInteger counts = faceSubject.faceModels.count;
    
    NSMutableArray *page = nil;
    for (int i = 0; i < counts; ++i) {
        if (i % (colNumber * lineNumber - 1) == 0) {
            page = [NSMutableArray array];
            [pagesArray addObject:page];
        }
        [page addObject:faceSubject.faceModels[i]];
    }
    self.pageFaceArray = [NSArray arrayWithArray:pagesArray];
    
    _pageControl.numberOfPages = self.pageFaceArray.count;
    _pageControl.currentPage = 0;
}


//列数
- (NSInteger)colNumber:(FaceSubjectModel *)faceSubject
{
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    NSInteger number = 6;
    if (faceSubject.faceSize == SubjectFaceSizeKindSmall) {
        if (w == 320) {
            number = 7;
        }else if(w == 375){
            number = 8;
        }else if (w == 414){
            number = 9;
        }
    }else if (faceSubject.faceSize == SubjectFaceSizeKindMiddle){
        number = 2;
    }else {
        number = 2;
    }
    return number;
}

//行数
- (NSInteger)lineNumber:(FaceSubjectModel *)faceSubject{
    NSInteger lineNumber;
    if (faceSubject.faceSize == SubjectFaceSizeKindSmall) {
        lineNumber = 3;
    }else if (faceSubject.faceSize == SubjectFaceSizeKindMiddle){
        lineNumber = 2;
    }else {
        lineNumber = 2;
    }
    return lineNumber;
}

@end
