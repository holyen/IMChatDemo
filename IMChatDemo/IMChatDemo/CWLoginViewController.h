//
//  CWLoginViewController.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-12-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWLoginViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *hostTextField;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonTap:(id)sender;

@end
