//
//  ChatFacePanel.m
//  FaceKeyboard
//
//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FacePanel.h"
#import "FaceView.h"
#import "FaceSourceManager.h"

#define FacePanelHeight                 216
#define PanelBottomToolHeight           40

NSString *const faceViewIdentifier = @"faceViewIdentifier";

@interface FacePanel () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *faceSources;

@end

@implementation FacePanel
{
    UICollectionView *_collectionView;
}


+ (instancetype)facePanel
{
     return [[self alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-216, [[UIScreen mainScreen] bounds].size.width, 216)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFrame];
    }
    return self;
}

- (void)setupFrame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //这个 item 表示cell的大小
    flowLayout.itemSize = CGSizeMake(self.frame.size.width,  FacePanelHeight-PanelBottomToolHeight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, FacePanelHeight-PanelBottomToolHeight) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0f];
    
    [_collectionView registerClass:[FaceView class] forCellWithReuseIdentifier:faceViewIdentifier];
    [self addSubview:_collectionView];
    
    self.faceSources = [FaceSourceManager loadFaceSource];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.faceSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FaceView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:faceViewIdentifier forIndexPath:indexPath];
    [cell loadFaceSubject:self.faceSources[indexPath.row]];
    return cell;
}

@end
