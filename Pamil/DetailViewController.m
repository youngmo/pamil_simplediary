//
//  DetailViewController.m
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import "DetailViewController.h"
#import "Day.h"
#import "PhotoCell.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize scrollView;
@synthesize _collectionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        imageList = [[NSMutableArray alloc] init];
        //magePathList= [[NSMutableArray alloc] init];
        inputPhoto = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 변수 초기화
    //time = 0;
    
    //[scrollView becomeFirstResponder];  //키보드 보이게 하기
    
    // back버튼 타이틀 변경을 위해 네비 타이틀을 일시적으로 변경
    self.navigationController.navigationBar.topItem.title = @"List";
    
    // 오른쪽버튼
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                 target:self
                                                                                 action:@selector(photoButtonAction:)];
    //self.navigationItem.rightBarButtonItem = photoButton;
    
    // 오른쪽버튼
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                  target:self
                                                                                  action:@selector(deleteButtonAction:)];
    
    NSMutableArray *rightButtonList = [[NSMutableArray alloc] init];
    [rightButtonList addObject:photoButton];
    [rightButtonList addObject:deleteButton];
    self.navigationItem.rightBarButtonItems = rightButtonList;
    
    // 노티피케이션 등록
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(setContentWithNoti:) name:@"setContent" object:nil];
    
    [self._collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - 사진삭제버튼
- (IBAction)deleteButtonAction:(id)sender {
    
    [imageList removeAllObjects];
    [imagePathList removeAllObjects];
    
    [_collectionView reloadData];
    inputPhoto = false;
}

# pragma mark - 뒤로가기버튼
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES]; 
}

# pragma mark - 사진추가버튼
- (IBAction)photoButtonAction:(id)sender {
    
    if (imageList.count == 3) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                       message:@"Not be able to add more picture"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
        
    } else {
        UIActionSheet *actionSheet;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"cancel"
                                        destructiveButtonTitle:nil  //@"Take Photo"      // 사진찍기는 아직 미구현
                                             otherButtonTitles:@"Choose From Library", nil];
        } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Choose From Library", nil];
        }
        UIView *view = [[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0];
        [actionSheet showInView:view];
    }
}

# pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 캔슬 버튼일 경우
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setDelegate:self];
    
    // 사진찍기 버튼일 경우
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // 사진첩에서 고르기 버튼일 경우
    if (buttonIndex == [actionSheet firstOtherButtonIndex]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePickerController setAllowsEditing:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

# pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setImage:[imageList objectAtIndex:indexPath.row]];
	
	return cell;
}

# pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSURL *imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // viewDidLayoutSubviews 에서 화면을 갱신하기 위해
    inputPhoto = true;
    
    [imageList addObject:image];
    [imagePathList addObject:imagePath];
    [_collectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
    //NSLog(@"didPresentActionSheet");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //NSLog(@"didShowViewController");
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //NSLog(@"willShowViewController");
}

- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"viewWillAppear");
}

- (void)viewWillLayoutSubviews {
    //NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    //NSLog(@"viewDidLayoutSubviews");
    
    // 사진 콜렉션 표시가 안되어 있을 때
    if (inputPhoto == true) {
        _collectionView.hidden = NO;
        CGRect newFrame_ = [scrollView frame];
        newFrame_.origin.y = 100;
        newFrame_.size.height -= 100;
        [scrollView setFrame:newFrame_];
    } else {
        _collectionView.hidden = YES;
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    //NSLog(@"willMoveToParentViewController");
    
    // 부모화면으로 돌아갈 때만 실행
    if (scrollView != nil) {
        // 파일 저장
        NSTimeInterval now = time;  // 날짜값
        
        NSString *nowString = [NSString stringWithFormat:@"%f", now];
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                     NSUserDomainMask,
                                                                     YES);
        
        NSString *documentRootPath = [documentPaths objectAtIndex:0];
        NSFileManager* fm = [NSFileManager defaultManager];
        
        // 일기 내용 저장용 파일
        NSString *textFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary.plist"];
        NSDictionary *diaryDic = nil;
        if ( [fm fileExistsAtPath:textFilePath] == YES ) {
            NSMutableDictionary *diaryDic_ = [[NSMutableDictionary alloc] initWithContentsOfFile:textFilePath];
            [diaryDic_ setObject:scrollView.text forKey:nowString];
            diaryDic = diaryDic_;
        } else {
            diaryDic = [[NSDictionary alloc] initWithObjectsAndKeys:scrollView.text, nowString, nil];
        }
        
        BOOL isWritten = NO;
        isWritten = [diaryDic writeToFile:textFilePath atomically:YES];
        
        // 사진 저장용 파일
        NSString *photoFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary_photo.plist"];
        NSDictionary *photoDic = nil;
        NSData *nsData = [NSKeyedArchiver archivedDataWithRootObject:imagePathList];
        if ( [fm fileExistsAtPath:photoFilePath] == YES ) {
            NSMutableDictionary *photoDic_ = [[NSMutableDictionary alloc] initWithContentsOfFile:photoFilePath];
            [photoDic_ setObject:nsData forKey:nowString];
            photoDic = photoDic_;
        } else {
            photoDic = [[NSDictionary alloc] initWithObjectsAndKeys:nsData, nowString, nil];
        }
        
        isWritten = NO;
        isWritten = [photoDic writeToFile:photoFilePath atomically:YES];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    //NSLog(@"willRotateToInterfaceOrientation");
}

- (void)viewWillDisappear:(BOOL)animated {
    //NSLog(@"viewWillDisappear");
    [self subscribeToKeyboardEvents:NO];
}

- (void)viewDidUnload {
    //NSLog(@"viewDidUnload");
    
    [self setScrollView:nil];
    [super viewDidUnload];
    
    // 변수 초기화
    time = 0;
    inputPhoto = false;
    [imageList removeAllObjects];
    [imagePathList removeAllObjects];
    
    // 노티피케이션 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"setContent" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self subscribeToKeyboardEvents:YES];
}

# pragma mark - 노티피케이션 호출받았을 때
- (void)setContentWithNoti:(NSNotification *)noti {
    NSDictionary *notiDic = [noti userInfo];
    Day *content = [notiDic objectForKey:@"content"];
    
    time = content.time;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *title = [dateFormatter stringFromDate:date];
    
    self.navigationItem.title = title;
    [scrollView setText:content.content];
    
    if (scrollView.text.length == 0) {
        [scrollView becomeFirstResponder];
    }
    
    // 사진 불러오기
    NSString *nowString = [NSString stringWithFormat:@"%f", time];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *photoFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary_photo.plist"];
    
    NSMutableDictionary *diaryDic = [[NSMutableDictionary alloc] initWithContentsOfFile:photoFilePath];
    
    NSData *nsData = [diaryDic objectForKey:nowString];
    NSArray *photoPathList = [NSKeyedUnarchiver unarchiveObjectWithData:nsData];
    imagePathList= [[NSMutableArray alloc] initWithArray:photoPathList];
    //imagePathList = photoPathList.copy;
    
    for (int i = 0; i < photoPathList.count; i++) {
        NSURL *path = [photoPathList objectAtIndex:i];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library assetForURL:path resultBlock:^(ALAsset *asset) {
            // code to handle the asset here
            UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
            [imageList addObject:image];
            
            if (i == photoPathList.count - 1) {
                // viewDidLayoutSubviews 에서 화면을 갱신하기 위해
                inputPhoto = true;
            }
            
        } failureBlock:^(NSError *error) {
            // error handling
        }];
    }
}

# pragma mark - 키보드

// 필요없나?
- (void) keyboardWillHide:(NSNotification *)nsNotification {
    
    NSDictionary * userInfo = [nsNotification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect newFrame = [scrollView frame];
    
    CGFloat kHeight = kbSize.height;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        kHeight = kbSize.width;
    }
    
    newFrame.size.height += kHeight;
    
    // save the content offset before the frame change
    CGPoint contentOffsetBefore = scrollView.contentOffset;
    
    [scrollView setHidden:YES];
    
    // set the new frame
    [scrollView setFrame:newFrame];
    
    // get the content offset after the frame change
    CGPoint contentOffsetAfter =  scrollView.contentOffset;
    
    // content offset initial state
    [scrollView setContentOffset:contentOffsetBefore];
    
    [scrollView setHidden:NO];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [scrollView setContentOffset:contentOffsetAfter];
                     }
                     completion:^(BOOL finished){
                         // do nothing for the time being...
                     }
     ];
    
}

- (void) keyboardDidShow:(NSNotification *)nsNotification {
    
    NSDictionary * userInfo = [nsNotification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect newFrame = [scrollView frame];
    
    CGFloat kHeight = kbSize.height;
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
        kHeight = kbSize.width;
    }
    
    newFrame.size.height -= kHeight;
    
    [scrollView setFrame:newFrame];
}

- (void)subscribeToKeyboardEvents:(BOOL)subscribe {
    
    if (subscribe) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
