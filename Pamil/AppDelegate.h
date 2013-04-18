//
//  AppDelegate.h
//  Simple Diary_
//
//  Created by an_yommo on 13/03/24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewController;
@class DetailViewController;
@class LoginViewController;
@class PwdViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TableViewController *listController;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) LoginViewController *loginViewController;

@property (strong, nonatomic) PwdViewController *pwdViewController;

@end
