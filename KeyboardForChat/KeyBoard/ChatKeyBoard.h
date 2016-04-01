//
//  ChatKeyBoard.h
//  FaceKeyboard
//
//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatToolBar;
@class FacePanel;
@class MorePanel;

@class MoreItem;
@class ChatToolBarItem;
@class FaceSubjectModel;

@class ChatKeyBoard;
@protocol ChatKeyBoardDelegate <NSObject>
@optional
/**
 *  语音状态
 */
- (void)chatKeyBoardDidStartRecording:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardDidCancelRecording:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardDidFinishRecoding:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardWillCancelRecoding:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardContineRecording:(ChatKeyBoard *)chatKeyBoard;

/**
 *  输入状态
 */
- (void)chatKeyBoardTextViewDidBeginEditing:(UITextView *)textView;
- (void)chatKeyBoardSendText:(NSString *)text;
- (void)chatKeyBoardTextViewDidChange:(UITextView *)textView;

/**
 * 表情
 */
- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceSize:(NSInteger)faceSize faceName:(NSString *)faceName delete:(BOOL)isDelete;
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard;

/**
 *  更多功能
 */
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index;

@end

/**
 *  数据源
 */
@protocol ChatKeyBoardDataSource <NSObject>

@required
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems;
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems;
- (NSArray<FaceSubjectModel *> *)chatKeyBoardFacePanelSubjectItems;
@end

@interface ChatKeyBoard : UIView

+ (instancetype)keyBoard;

@property (nonatomic, weak) id<ChatKeyBoardDataSource> dataSource;
@property (nonatomic, weak) id<ChatKeyBoardDelegate> delegate;

@property (nonatomic, readonly, strong) ChatToolBar *chatToolBar;
@property (nonatomic, readonly, strong) FacePanel *facePanel;
@property (nonatomic, readonly, strong) MorePanel *morePanel;
/**
 *  是否开启语音, 默认开启
 */
@property (nonatomic, assign) BOOL allowVoice;
/**
 *  是否开启表情，默认开启
 */
@property (nonatomic, assign) BOOL allowFace;
/**
 *  是否开启更多功能，默认开启
 */
@property (nonatomic, assign) BOOL allowMore;
/**
 *  是否开启切换工具条的功能，默认关闭
 */
@property (nonatomic, assign) BOOL allowSwitchBar;


@end










