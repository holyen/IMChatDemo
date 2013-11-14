//
//  CWMainViewController.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWMainViewController.h"
#import "CWChatCell.h"
//!!! TEST
#import "CWSQLUtility.h"
#import "CWMessageInfo.h"

@interface CWMainViewController ()

@end

@implementation CWMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _messageModel = [[CWMessageModel alloc] init];
        [_messageModel addObserver:self
                        forKeyPath:KVO_MESSAGES_PATH
                           options:NSKeyValueObservingOptionNew
                           context:nil];
        [_messageModel messagesFromUserInfoId:1000 toUserInfoId:1001 pageIndex:0];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChange:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        _chatToolView = [[[NSBundle mainBundle] loadNibNamed:@"CWChatToolView" owner:self options:nil] objectAtIndex:0];
        _chatToolView.frame = CGRectMake(0, self.view.bounds.size.height - 44, 320, 260);
        _chatToolView.delegate = self;
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == _messageModel) {
        if ([keyPath isEqualToString:KVO_MESSAGES_PATH]) {
            [_tableView reloadData];
            return;
        }
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat distanceToMove = kbSize.height;
    CGPoint viewCenter = CGPointMake(320 / 2, self.view.bounds.size.height / 2);
    viewCenter.y = viewCenter.y - distanceToMove;
    self.view.center = viewCenter;
    [self updateChatToolViewFrameByNormalState:YES];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    CGPoint viewCenter = CGPointMake(320 / 2, self.view.bounds.size.height / 2);
    self.view.center = viewCenter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_chatToolView];
}

- (void)updateChatToolViewFrameByNormalState:(BOOL)aNormalState
{
    //aNormalState 是非表情,添加附加的另一种状态.
    CGFloat showHeight = 0;
    if (aNormalState) {
        showHeight = 44;
    } else {
        showHeight = 260;
    }
    
    CGRect chatToolViewFrame = _chatToolView.frame;
    chatToolViewFrame.origin.y = self.view.bounds.size.height - showHeight;
    _chatToolView.frame = chatToolViewFrame;
}

#pragma mark -
#pragma mark - CWChatToolViewDelegate

- (void)emotionButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView
{
    [self updateChatToolViewFrameByNormalState:NO];
}

- (void)speakButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView
{
    [self updateChatToolViewFrameByNormalState:YES];
}

- (void)moreSelectorViewTapInChatToolView:(CWChatToolView *)aChatToolView type:(NSNumber *)aType
{
    
    SelectorMode type = (SelectorMode)[aType integerValue];
    switch (type) {
        case MORE_SELECTOR_PHOTO:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//图像选取器
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//打开相册
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//过渡类型,有四种
            imagePicker.allowsEditing = NO;//禁止对图片进行编辑
            //打开模态视图控制器选择图像
            PresentViewController(self, imagePicker, YES, nil);
        }
            break;
        case MORE_SELECTOR_CAMERA:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//照片来源为相机
                imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                PresentViewController(self, imagePicker, YES, nil);
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"该设备没有照相机"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }
            break;
            
        default:
            NSAssert(0, @"not handle type");
            break;
    }
}

- (void)addOthersButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView
{
    CGPoint viewCenter = CGPointMake(320 / 2, self.view.bounds.size.height / 2);
    self.view.center = viewCenter;
    [self updateChatToolViewFrameByNormalState:NO];
}

#pragma mark - 从相册选择照片后，回调
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//将拍到的图片保存到相册
    }
    //关闭模态视图控制器
    DismissViewController(self, NO, nil);
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageModel.messagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const chatCellID = @"CWMainViewController.tableview.cell";
    UITableViewCell *chatCell = [tableView dequeueReusableCellWithIdentifier:chatCellID];
    if (!chatCell) {
        chatCell = [[[CWChatCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:chatCellID
                                          messageInfo:[_messageModel.messagesArray objectAtIndex:indexPath.row]] autorelease];
    }
    
    return chatCell;
}

- (void)dealloc {
    [_messageModel removeObserver:self forKeyPath:KVO_MESSAGES_PATH];
    [_messageModel release];
    [_tableView release];
    [_chatToolView release];
    [super dealloc];
}
@end
