//
//  MessageViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/5/16.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatKeyBoard.h"

@interface MessageViewController ()<ChatKeyBoardDelegate, ChatKeyBoardDataSource, UITableViewDataSource, UITableViewDelegate>
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, weak) UITableView *messageTableView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    messageTableView.delegate = self;
    messageTableView.dataSource = self;
    [self.view addSubview:messageTableView];
    self.messageTableView = messageTableView;
    
    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    [self.view addSubview:self.chatKeyBoard];
    
    
    [self addObserver:self forKeyPath:@"self.chatKeyBoard.frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeObserver:self forKeyPath:@"self.chatKeyBoard.frame" context:nil];
}


#pragma mark -- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"self.chatKeyBoard.frame"])
    {
        CGRect newRect = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat lastMessageheight = self.messageTableView.frame.size.height;
            
            if (lastMessageheight != newRect.origin.y)
            {
                [UIView animateWithDuration:0.25 animations:^{
                    self.messageTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, newRect.origin.y);
                    if (self.messageTableView.contentSize.height> self.messageTableView.frame.size.height) {
                        CGPoint point = CGPointMake(0, self.messageTableView.contentSize.height - self.messageTableView.frame.size.height);
                        self.messageTableView.contentOffset = point;
                    }
                }];
            }
        });
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"demo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" %zd", indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDown];
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        themeM.themeStyle = FaceThemeStyleCustomEmoji;
        themeM.themeDecribe = [NSString stringWithFormat:@"f%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}

@end

