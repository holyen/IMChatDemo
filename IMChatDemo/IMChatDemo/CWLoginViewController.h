//
//  CWLoginViewController.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-12-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"

@interface CWLoginViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) XMPPUserCoreDataStorageObject *xmppUserObject;
@property (retain, nonatomic) IBOutlet UITextField *hostTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UITextField *sendJIDTextField;
@property (retain, nonatomic) IBOutlet UITextField *sendContentTextField;
@property (retain, nonatomic) IBOutlet UIImageView *sendToBeShowImageView;

- (IBAction)loginButtonTap:(id)sender;
- (IBAction)sendButtonTap:(id)sender;
- (IBAction)getFriendsButtonTap:(id)sender;
- (IBAction)addFriendButtonTap:(id)sender;


@end
