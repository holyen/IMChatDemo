//
//  CWAppDelegate.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-10-30.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWMainViewController.h"
#import "CWLoginViewController.h"
#import "XMPPFramework.h"
@protocol ChatDelegate;

@interface CWAppDelegate : UIResponder <UIApplicationDelegate, XMPPStreamDelegate>
{
    
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

@property (nonatomic, strong) XMPPStream *xmppStream;

@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;

@property (nonatomic, strong) XMPPRoster *xmppRoster;

@property (nonatomic, strong) XMPPReconnect *xmppReconnect;

@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;

@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;

@property (nonatomic, assign) id<ChatDelegate> chatDelegate;

- (BOOL)myConnect;

- (void)showAlertView:(NSString *)message;

@end

@protocol ChatDelegate <NSObject>

-(void)friendStatusChange:(CWAppDelegate *)appD Presence:(XMPPPresence *)presence;
-(void)getNewMessage:(CWAppDelegate *)appD Message:(XMPPMessage *)message;

@end