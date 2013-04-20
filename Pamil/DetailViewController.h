//
//  DetailViewController.h
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DetailViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource> {
    double time;
    Boolean inputPhoto;
    NSMutableArray *imageList;
    NSMutableArray *imagePathList;
}

@property (strong, nonatomic) IBOutlet UITextView *scrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *_collectionView;


@end
