//
//  DetailViewController.m
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import "DetailViewController.h"
#import "Day.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize scrollView;

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
    
    // 변수 초기화
    //time = 0;
    
    //[scrollView becomeFirstResponder];  //키보드 보이게 하기
    
    // 오른쪽버튼
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"photo"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // back버튼 타이틀 변경을 위해 네비 타이틀을 일시적으로 변경
    self.navigationController.navigationBar.topItem.title = @"List";
    
    // 노티피케이션 등록
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(setContentWithNoti:) name:@"setContent" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - 오른쪽버튼
- (IBAction)rightButtonAction:(id)sender {
    NSLog(@"anTest01");
}

# pragma mark - 키보드

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

- (void)viewWillDisappear:(BOOL)animated{
    [self subscribeToKeyboardEvents:NO];
    
    // 파일 저장
    NSTimeInterval now = time;  // 날짜값
    
    NSString *nowString = [NSString stringWithFormat:@"%f", now];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary.plist"];
    
    // 파일 존재여부 확인
    NSDictionary *diaryDic = nil;
    NSFileManager* fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:stringFilePath] == YES ) {
        NSMutableDictionary *diaryDic_ = [[NSMutableDictionary alloc] initWithContentsOfFile:stringFilePath];
        [diaryDic_ setObject:scrollView.text forKey:nowString];
        diaryDic = diaryDic_;
    } else {
        diaryDic = [[NSDictionary alloc] initWithObjectsAndKeys:scrollView.text, nowString, nil];
    }
    
    BOOL isWritten = NO;
    isWritten = [diaryDic writeToFile:stringFilePath atomically:YES];
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
    
    // 변수 초기화
    time = 0;
    
    // 노티피케이션 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"setContent" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [self subscribeToKeyboardEvents:YES];
}

- (void)subscribeToKeyboardEvents:(BOOL)subscribe{
    
    if(subscribe){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
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
}

@end
