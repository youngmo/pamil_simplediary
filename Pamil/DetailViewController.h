//
//  DetailViewController.h
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
    double time;
}

@property (strong, nonatomic) IBOutlet UITextView *scrollView;

@end
