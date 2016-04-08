# KeyboardForChat
仿微信聊天键盘。  
优点：无污染，无任何第三方，使用简单。

博客：[devcai.com](http://devcai.com)  

  qq: 2581502433@qq.com
  
#特性
1. 支持语音、表情、more，并且可以主动选择
2. 表情采用collectionView，节约内存空间
3. 支持placehold
4. 支持在控制器比较复杂的界面上添加，比如子视图控制器。注意初始化方法,传入的frame.
5. 支持切换评论键盘.
6. 支持在外部切换聊天键盘

# 控件使用效果
![](2016-04-08 18_58_24.gif)

# 控件使用步骤

## 代码
1. 导入KeyBoard文件夹  
2. 资源文件是 emotion.plist 和 face.plist 图片在 Assets.xcassets
3. 导入ChatKeyBoard.h即可使用，具体参考demo

## 添加数据源
```objc
    /****************************************************************
     *  关于初始化方法
     *
     *  1，如果只是一个带导航栏的页面，且导航栏透明。
           或者根本就没有导航栏
     *
     *  使用  [ChatKeyBoard keyBoard]; 
             [ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES]
     *       [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]
     *
     *
     *  2，如果只是一个带导航栏的页面，导航栏不透明
     
     * 使用  [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO]
            [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)]
     *
     *
     *  3, 如果页面顶部还有一些标签栏，类似腾讯视频、今日头条、网易新闻之类的
     *
     * 请使用  [ChatKeyBoard keyBoardWithParentViewBounds:bounds]
        传入子视图控制器的bounds
     *
     ******************************************************************/

    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    self.chatKeyBoard.placeHolder = @"请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息";
    
    /*
     *  支持切换评论键盘
     *  self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
     *
     *  则可以使用下面两个方法，开启评论和关闭评论键盘
     - (void)keyboardUpforComment;
     - (void)keyboardDownForComment;
     */
     
    /*
     *  支持外部操纵键盘  (这两个方法是在正常聊天界面，非评论)
    - (void)keyboardUp;
    - (void)keyboardDown;
     */
    
    [self.view addSubview:self.chatKeyBoard];
```

## 实现数据源代理
```objc
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

- (NSArray<FaceSubjectModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}
```

##控件里面的一些View可以自己定制，里面只是稍微演示
`PanelBottomView`
`OfficialAccountToolbar`

##控件可以根据业务需要，更换业务模型
`MoreItem`  
`ChatToolBarItem`  
`FaceSubjectModel`   
`FaceSourceManager`   

##感谢  
`MessageDisplayKit`
`JSQMessagesViewController`
