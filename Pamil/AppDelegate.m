//
//  AppDelegate.m
//  Simple Diary_
//
//  Created by an_yommo on 13/03/24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "TableViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "PwdViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize listController = _listController;
@synthesize loginViewController = _loginViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    self.pwdViewController = [[PwdViewController alloc] initWithNibName:@"PwdViewController" bundle:nil];
    
    // 사전읽기
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/simple_diary_setting.plist"];
    
    // 파일 존재여부 확인
    NSFileManager* fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:stringFilePath] == YES ) {
        self.window.rootViewController = self.pwdViewController;
        
    } else {
        TableViewController *listController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:listController];
        
        self.window.rootViewController = navi;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
