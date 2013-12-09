//
//  CWLoginViewController.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-12-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWLoginViewController.h"
#import "CWAppDelegate.h"
#import "NSData+Base64.h"
#import "CWUtility.h"

@interface CWLoginViewController ()

@end

@implementation CWLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray = [[NSMutableArray alloc] init];
        NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
        [noti addObserver:self
                 selector:@selector(messageReceived:)
                     name:@"didReceiveMessage" object:nil];
    }
    return self;
}

- (void)messageReceived:(id)aPhotoImage
{
    NSNotification *noti = aPhotoImage;
    
    UIImage *image = noti.object;
    self.sendToBeShowImageView.image = image;
}

- (CWAppDelegate *)appDelegate
{
	return (CWAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dataArray release];
    [_xmppUserObject release];
    [_hostTextField release];
    [_userNameTextField release];
    [_passwordTextField release];
    [_sendJIDTextField release];
    [_sendContentTextField release];
    [_sendToBeShowImageView release];
    [super dealloc];
}

- (void)getData{
    NSManagedObjectContext *context = [[[self appDelegate] xmppRosterStorage] mainThreadManagedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSError *error ;
    NSArray *friends = [context executeFetchRequest:request error:&error];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:friends];
}

- (IBAction)loginButtonTap:(id)sender {
    [[self appDelegate].xmppStream setHostName:self.hostTextField.text];
    [[self appDelegate].xmppStream setHostPort:5222];
    [[NSUserDefaults standardUserDefaults]setObject:self.hostTextField.text forKey:kHost];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@@%@/XMPPIOS",self.userNameTextField.text,self.hostTextField.text] forKey:kMyJID];
    [[NSUserDefaults standardUserDefaults]setObject:self.passwordTextField.text forKey:kPS];
    [[self appDelegate] myConnect];
}

- (IBAction)sendButtonTap:(id)sender {
//    XMPPUserCoreDataStorageObject *object = [self.dataArray objectAtIndex:0];
    XMPPJID *jid = [XMPPJID jidWithString:@"liyuhui@192.168.0.24/XMPPIOS"];
//    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
//    [message addBody:self.sendContentTextField.text];
//    [[[self appDelegate] xmppStream] sendElement:message];
   
    //语音
    NSData * soundData = [NSData dataWithContentsOfFile:@"/var/mobile/Applications/EC12D021-211E-4CDC-96EF-33E40266F45F/Documents/20131206141153.wav"];
    NSString *sound=[soundData base64EncodedString];
    NSData *data = [NSData dataWithBase64EncodedString:sound];
    [data writeToFile:@"/var/mobile/Applications/EC12D021-211E-4CDC-96EF-33E40266F45F/Documents/1.wav" atomically:YES];
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:sound];
    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    NSString *to = [NSString stringWithFormat:@"%@", jid];
    [message addAttributeWithName:@"to" stringValue:to];
    [message addChild:body];
    [[[self appDelegate]xmppStream] sendElement:message];
    
    //图片

//    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
//    [body setStringValue:[CWUtility image2String:[UIImage imageWithContentsOfFile:@"/var/mobile/Applications/EC12D021-211E-4CDC-96EF-33E40266F45F/Documents/Test.png"]]];
//    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
//    [message addAttributeWithName:@"type" stringValue:@"chat"];
//    NSString *to = [NSString stringWithFormat:@"%@", jid];
//    [message addAttributeWithName:@"to" stringValue:to];
//    [message addChild:body];
//    [[[self appDelegate]xmppStream] sendElement:message];
    
}

- (IBAction)getFriendsButtonTap:(id)sender {
    [self getData];
}

- (IBAction)addFriendButtonTap:(id)sender {
    [[[self appDelegate] xmppRoster] addUser:[XMPPJID jidWithString:@"lizhengxing@192.168.0.24"] withNickname:@"lizhengxing"];
}

@end
