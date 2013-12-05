//
//  CWAppDelegate.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-10-30.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWAppDelegate.h"

@implementation CWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //self.viewController = [[CWMainViewController alloc] initWithNibName:nil bundle:nil];
    self.viewController = [[CWLoginViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = _viewController;
    [self.window makeKeyAndVisible];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self setupStream];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_xmppStream release];
    [_xmppRosterStorage release];
    [_xmppRoster release];
    [_xmppReconnect release];
    [_xmppMessageArchivingCoreDataStorage release];
    [_xmppMessageArchivingModule release];
    
    [super dealloc];
}

- (void)showAlertView:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -
#pragma mark - XMPP
- (void)setupStream
{
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _xmppReconnect = [[XMPPReconnect alloc] init];
    [_xmppReconnect activate:self.xmppStream];
    
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    
    _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterStorage];
    [_xmppRoster activate:self.xmppStream];
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    
    _xmppMessageArchivingModule = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage];
    [_xmppMessageArchivingModule setClientSideMessageArchivingOnly:YES];
    [_xmppMessageArchivingModule activate:_xmppStream];
    [_xmppMessageArchivingModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (BOOL)myConnect
{
    NSString *jid = [[NSUserDefaults standardUserDefaults] objectForKey:kMyJID];
    NSString *ps = [[NSUserDefaults standardUserDefaults] objectForKey:kPS];
    if (jid == nil || ps == nil) {
        return NO;
    }
    XMPPJID *myJID = [XMPPJID jidWithString:[[NSUserDefaults standardUserDefaults] objectForKey:kMyJID]];
    NSError *error;
    [_xmppStream setMyJID:myJID];
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        NSLog(@"my connected error : %@", error.description);
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark - XMPPStreamDelegate
- (void)xmppStreamWillConnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamWillConnect");
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidConnect");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kPS]) {
        NSError *error;
        if (![self.xmppStream authenticateWithPassword:[[NSUserDefaults standardUserDefaults] objectForKey:kPS] error:&error]) {
            NSLog(@"error authenticate : %@", error.description);
        }
    }
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidRegister");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kPS]) {
        NSError *error;
        if (![self.xmppStream authenticateWithPassword:[[NSUserDefaults standardUserDefaults] objectForKey:kPS] error:&error]) {
            NSLog(@"error authenticate : %@", error.description);
        }
    }
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    [self showAlertView:@"当前用户已经存在"];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidAuthenticate");
    XMPPPresence *presence = [XMPPPresence presence];
    [self.xmppStream sendElement:presence];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"didNotAuthenticate : %@", error.description);
}

- (NSString *)xmppStream:(XMPPStream *)sender
alternativeResourceForConflictingResource:(NSString *)conflictingResource
{
    NSLog(@"alternativeResourceForConflictingResource : %@", conflictingResource);
    return @"XMPPIOS";//!!!
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"didReceiveIQ : %@", iq.description);
    return YES;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"didReceiveMessage : %@", message.description);
    if ([self.chatDelegate respondsToSelector:@selector(getNewMessage:Message:)]) {
        [self.chatDelegate getNewMessage:self Message:message];
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"didReceivePresence : %@", presence.description);
    if (presence.status) {
        if ([self.chatDelegate respondsToSelector:@selector(friendStatusChange:Presence:)]) {
            [self.chatDelegate friendStatusChange:self Presence:presence];
        }
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(DDXMLElement *)error
{
    NSLog(@"didReceiveError : %@", error.description);
}

- (void)xmppStream:(XMPPStream *)sender didSendIQ:(XMPPIQ *)iq
{
    NSLog(@"didSendIQ : %@", iq.description);
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"didSendMessage : %@", message.description);
}

- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence
{
    NSLog(@"didSendPresence : %@", presence.description);
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    NSLog(@"didFailToSendIQ : %@", error.description);
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSLog(@"didFailToSendMessage:%@",error.description);
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error
{
    NSLog(@"didFailToSendPresence:%@",error.description);
}

- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamWasToldToDisconnect");
}

- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    NSLog(@"xmppStreamConnectDidTimeout");
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"xmppStreamDidDisconnect: %@",error.description);
}

#pragma mark -
#pragma mark - XMPPRosterDelegate
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:presence.fromStr message:@"add" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"yes", nil];
    alertView.tag = 100001;
    [alertView show];
}

#pragma mark -
#pragma mark - XMPPReconnectDelegate
- (void)xmppReconnect:(XMPPReconnect *)sender
didDetectAccidentalDisconnect:(SCNetworkReachabilityFlags)connectionFlags
{
    NSLog(@"didDetectAccidentalDisconnect:%u",connectionFlags);
}

- (BOOL)xmppReconnect:(XMPPReconnect *)sender
shouldAttemptAutoReconnect:(SCNetworkReachabilityFlags)reachabilityFlags
{
    NSLog(@"shouldAttemptAutoReconnect:%u",reachabilityFlags);
    return YES;
}

#pragma mark -
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100001 && buttonIndex == 1) {
        XMPPJID *jid = [XMPPJID jidWithString:alertView.title];
        [[self xmppRoster] acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
