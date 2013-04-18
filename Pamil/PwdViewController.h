//
//  PwdViewController.h
//  Pamil
//
//  Created by an_yommo on 13/04/19.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *pwdText1;
@property (strong, nonatomic) IBOutlet UILabel *pwdText2;
@property (strong, nonatomic) IBOutlet UILabel *pwdText3;
@property (strong, nonatomic) IBOutlet UILabel *pwdText4;

@property (strong, nonatomic) IBOutlet UITextField *pwdHide;

- (IBAction)inputPwd:(id)sender;

@end
