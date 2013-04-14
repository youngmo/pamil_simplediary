//
//  LoginViewController.h
//  Pamil
//
//  Created by an_yommo on 13/04/14.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextField *pwdText;

- (IBAction)inputPwd:(id)sender;
- (IBAction)pushButton:(id)sender;

@end
