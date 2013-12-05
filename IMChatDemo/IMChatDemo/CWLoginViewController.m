//
//  CWLoginViewController.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-12-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWLoginViewController.h"
#import "CWAppDelegate.h"

@interface CWLoginViewController ()

@end

@implementation CWLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [_hostTextField release];
    [_userNameTextField release];
    [_passwordTextField release];
    [super dealloc];
}

- (IBAction)loginButtonTap:(id)sender {
    [[self appDelegate].xmppStream setHostName:self.hostTextField.text];
    [[self appDelegate].xmppStream setHostPort:5222];
    [[NSUserDefaults standardUserDefaults]setObject:self.hostTextField.text forKey:kHost];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@@%@/XMPPIOS",self.userNameTextField.text,self.hostTextField.text] forKey:kMyJID];
    [[NSUserDefaults standardUserDefaults]setObject:self.passwordTextField.text forKey:kPS];
    [[self appDelegate] myConnect];
}

@end
