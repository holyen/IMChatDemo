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

@interface CWLoginViewController ()

@end

@implementation CWLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
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
    XMPPUserCoreDataStorageObject *object = [self.dataArray objectAtIndex:0];
    XMPPJID *jid = [XMPPJID jidWithString:@"zouhongyuan@192.168.0.24/XMPPIOS"];
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
    [message addBody:self.sendContentTextField.text];
    [[[self appDelegate] xmppStream] sendElement:message];

//    NSURL *url = [NSURL URLWithString:@"/var/mobile/Applications/EC12D021-211E-4CDC-96EF-33E40266F45F/Documents/20131206141153.wav"];
//    NSData *soundData = [[[NSData alloc] initWithContentsOfURL:url] autorelease];
//    NSString *sound = [soundData base64EncodedString];
//    [message addBody:sound];
//    [[[self appDelegate] xmppStream] sendElement:message];
}

- (IBAction)getFriendsButtonTap:(id)sender {
    [self getData];
}

- (IBAction)addFriendButtonTap:(id)sender {
    [[[self appDelegate] xmppRoster] addUser:[XMPPJID jidWithString:@"lizhengxing@192.168.0.24"] withNickname:@"lizhengxing"];
}

@end
