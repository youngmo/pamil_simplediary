//
//  LoginViewController.h
//  Pamil
//
//  Created by an_yommo on 13/04/14.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *pwdText1;
@property (strong, nonatomic) IBOutlet UITextField *pwdText2;
@property (strong, nonatomic) IBOutlet UITextField *pwdText3;
@property (strong, nonatomic) IBOutlet UITextField *pwdText4;

- (IBAction)inputPwd1:(id)sender;
- (IBAction)inputPwd2:(id)sender;
- (IBAction)inputPwd3:(id)sender;
- (IBAction)inputPwd4:(id)sender;

@end
