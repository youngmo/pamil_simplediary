//
//  SettingViewController.h
//  Pamil
//
//  Created by an_yommo on 13/04/19.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController <UITextFieldDelegate> {
    Boolean saveMode;
    NSMutableDictionary *diaryData;
    NSString *stringFilePath;
}

- (IBAction)inputPwdText:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *pwdText;

@property (strong, nonatomic) IBOutlet UILabel *settingText;

@property (strong, nonatomic) IBOutlet UILabel *pwdText1;
@property (strong, nonatomic) IBOutlet UILabel *pwdText2;
@property (strong, nonatomic) IBOutlet UILabel *pwdText3;
@property (strong, nonatomic) IBOutlet UILabel *pwdText4;

@end
