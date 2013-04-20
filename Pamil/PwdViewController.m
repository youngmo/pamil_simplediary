//
//  PwdViewController.m
//  Pamil
//
//  Created by an_yommo on 13/04/19.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import "PwdViewController.h"
#import "TableViewController.h"

@interface PwdViewController ()

@end

@implementation PwdViewController

@synthesize pwdText1;
@synthesize pwdText2;
@synthesize pwdText3;
@synthesize pwdText4;
@synthesize pwdHide;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 사전읽기
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                     NSUserDomainMask,
                                                                     YES);
        
        NSString *documentRootPath = [documentPaths objectAtIndex:0];
        
        NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/simple_diary_setting.plist"];
        
        NSMutableDictionary *diaryDic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringFilePath];
        
        pwd = [diaryDic valueForKey:@"password"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [pwdHide becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inputPwd:(id)sender {
    if (pwdHide.text.length == 0) {
        pwdText1.text = @".";
        pwdText2.text = @".";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdHide.text.length == 1) {
        pwdText1.text = @"*";
        pwdText2.text = @".";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdHide.text.length == 2) {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @".";
        pwdText4.text = @".";
        
    } else if (pwdHide.text.length == 3) {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @"*";
        pwdText4.text = @".";
    } else {
        pwdText1.text = @"*";
        pwdText2.text = @"*";
        pwdText3.text = @"*";
        pwdText4.text = @"*";
        
        if ([pwdHide.text isEqualToString:pwd]) {
            
            TableViewController *listController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:listController];
            
            [self presentViewController:navi animated:YES completion:nil];
        
        } else {
            pwdHide.text = @"";
            pwdText1.text = @".";
            pwdText2.text = @".";
            pwdText3.text = @".";
            pwdText4.text = @".";
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
