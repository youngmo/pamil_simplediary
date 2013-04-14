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

@synthesize pwdText;

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
    [pwdText becomeFirstResponder];
    [pwdText setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int maxLength = 3;
    
    if (string && string.length && textField.text.length > maxLength) {
        return NO;
    }
    return YES;
}

- (IBAction)inputPwd:(id)sender {
    //NSLog(@"anTest01");
    if (3 < pwdText.text.length) {
        if ([pwdText.text isEqualToString: @"1111"]) {
            
            TableViewController *listController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:listController];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
    }
}

- (IBAction)pushButton:(id)sender {
    TableViewController *listController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:listController];
    
    [self presentViewController:navi animated:YES completion:nil];
    //[self.view insertSubview:navi.view atIndex:0];
    //[self.view addSubview:navi];
}
@end
