//
//  SettingViewController.m
//  Pamil
//
//  Created by an_yommo on 13/04/19.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize pwdText;
@synthesize pwdText1;
@synthesize pwdText2;
@synthesize pwdText3;
@synthesize pwdText4;
@synthesize settingText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 사전읽기
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                     NSUserDomainMask,
                                                                     YES);
        
        NSString *documentRootPath = [documentPaths objectAtIndex:0];
        
        stringFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary_setting.plist"];
        
        // 파일 존재여부 확인
        NSFileManager* fm = [NSFileManager defaultManager];
        if ( [fm fileExistsAtPath:stringFilePath] == YES ) {
            saveMode = false;
        } else {
            saveMode = true;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 백버튼 지우기
    self.navigationController.navigationBar.topItem.hidesBackButton = YES;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelSetting:)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.topItem.title = @"Settings";
    
    if (saveMode == true) {
        [self setSaveMode];
    } else {
        [self setConfirmMode];
    }
    
    [pwdText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - 캔슬 버튼
- (IBAction)cancelSetting:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - 입력 모드 변경
- (void)setSaveMode {
    saveMode = true;
    settingText.text = @"Enter New Password";
    
    pwdText.text = @"";
    pwdText1.text = @".";
    pwdText2.text = @".";
    pwdText3.text = @".";
    pwdText4.text = @".";
}

- (void)setConfirmMode {
    saveMode = false;
    settingText.text = @"Enter Current Password";
    
    pwdText.text = @"";
    pwdText1.text = @".";
    pwdText2.text = @".";
    pwdText3.text = @".";
    pwdText4.text = @".";
}

# pragma mark - 입력 부분
- (IBAction)inputPwdText:(id)sender {
    if (pwdText.text.length == 0) {
        pwdText1.text = @".";
        pwdText2.text = @".";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdText.text.length == 1) {
        pwdText1.text = @"*";
        pwdText2.text = @".";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdText.text.length == 2) {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdText.text.length == 3) {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @"*";
        pwdText4.text = @".";
    } else {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @"*";
        pwdText4.text = @"*";
        
        if (saveMode == true) {
            // 파일 존재여부 확인
            NSDictionary *diaryDic = nil;
            NSFileManager* fm = [NSFileManager defaultManager];
            if ( [fm fileExistsAtPath:stringFilePath] == YES ) {
                NSMutableDictionary *diaryDic_ = [[NSMutableDictionary alloc] initWithContentsOfFile:stringFilePath];
                [diaryDic_ setObject:pwdText.text forKey:@"password"];
                diaryDic = diaryDic_;
            } else {
                diaryDic = [[NSDictionary alloc] initWithObjectsAndKeys:pwdText.text, @"password", nil];
            }
            BOOL isWritten = NO;
            isWritten = [diaryDic writeToFile:stringFilePath atomically:YES];
            
            [self.navigationController popViewControllerAnimated:YES]; 
        } else {
            NSMutableDictionary *diaryDic_ = [[NSMutableDictionary alloc] initWithContentsOfFile:stringFilePath];
            NSString *oldPwd = [diaryDic_ valueForKey:@"password"];
            
            if ([pwdText.text isEqualToString:oldPwd]) {
                // 현재 패스워드가 일치할 경우
                [self setSaveMode];
            } else {
                // 현재 패스워드가 일치하지 않을 경우
                pwdText.text = @"";
                pwdText1.text = @".";
                pwdText2.text = @".";
                pwdText3.text = @".";
                pwdText4.text = @".";
            }
        }
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int maxLength = 3;
    
    if (string && string.length && textField.text.length > maxLength) {
        return NO;
    }
    return YES;
}

@end
