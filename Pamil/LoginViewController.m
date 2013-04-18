//
//  LoginViewController.m
//  Pamil
//
//  Created by an_yommo on 13/04/14.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import "LoginViewController.h"
#import "TableViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize pwdText1;
@synthesize pwdText2;
@synthesize pwdText3;
@synthesize pwdText4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [pwdText1 becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard event

- (IBAction)inputPwd1:(id)sender {
    if (pwdText1.text.length == 1) {
        [pwdText2 becomeFirstResponder];
    }
    
    if (pwdText1.text.length == 0) {
        [pwdText1 becomeFirstResponder];
    }
}

- (IBAction)inputPwd2:(id)sender {
    if (pwdText2.text.length == 1) {
        [pwdText3 becomeFirstResponder];
    }
    
    if (pwdText2.text.length == 0) {
        [pwdText1 becomeFirstResponder];
    }
}

- (IBAction)inputPwd3:(id)sender {
    if (pwdText3.text.length == 1) {
        [pwdText4 becomeFirstResponder];
    }
    
    if (pwdText3.text.length == 0) {
        [pwdText2 becomeFirstResponder];
    }
}

- (IBAction)inputPwd4:(id)sender {
    if (pwdText4.text.length == 1) {
        
        NSMutableString *pwd = [NSMutableString string];
        [pwd appendString:pwdText1.text];
        [pwd appendString:pwdText2.text];
        [pwd appendString:pwdText3.text];
        [pwd appendString:pwdText4.text];
        
        if ([pwd isEqualToString: @"1111"]) {
                
            TableViewController *listController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:listController];
                
            [self presentViewController:navi animated:YES completion:nil];
        }
    }
    
    if (pwdText4.text.length == 0) {
        [pwdText3 becomeFirstResponder];
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int maxLength = 0;
    
    if (string && string.length && textField.text.length > maxLength) {
        if (textField == pwdText1) {
            [pwdText2 becomeFirstResponder];
            return YES;
        } else if (textField == pwdText2) {
            [pwdText3 becomeFirstResponder];
            return YES;
        } else if (textField == pwdText3) {
            [pwdText4 becomeFirstResponder];
            return YES;
        }
        return NO;
    }
    return YES;
}

@end
