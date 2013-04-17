//
//  TableViewController.h
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableDictionary *diaryData;
}

@end
