//
//  CWMainViewController.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWChatToolView.h"
#import "CWMessageModel.h"
#import "CWRecordUtility.h"

//!!!FIX ME
# define PresentViewController(vc1, vc2, animate, complete) [vc1 presentViewController:vc2 animated:animate completion:complete]
# define DismissViewController(vc, animate, complete) [vc dismissViewControllerAnimated:animate completion:complete]

@interface CWMainViewController : UIViewController <CWChatToolViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    CWMessageModel *_messageModel;
    CWRecordUtility *_recordUtility;
}

@property (retain, nonatomic) CWChatToolView *chatToolView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
