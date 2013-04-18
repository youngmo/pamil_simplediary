//
//  TableViewController.m
//  Simple Diary_
//
//  Created by an_yommo on 13/03/29.
//
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "SettingViewController.h"
#import "Day.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Simple Diary";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // 저장버튼 
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(writeDiary:)];
    self.navigationItem.rightBarButtonItem = newButton;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 설정버튼
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"Setting"
                                                                      style:nil
                                                                     target:self
                                                                     action:@selector(setting:)];
    self.navigationItem.leftBarButtonItem = settingButton;
    
    [self loadDiaryDic];
}

- (void) loadDiaryDic {
    // 타이틀 되돌려놓기
    self.navigationController.navigationBar.topItem.title = self.title;
    
    // 사전읽기
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingFormat:@"/simple_diary.plist"];
    
    NSMutableDictionary *diaryDic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringFilePath];
    
    diaryData = diaryDic;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 사전갱신
    [self loadDiaryDic];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return diaryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = [diaryData.allKeys objectAtIndex:indexPath.row];
    double item_ = [item doubleValue];
    
    // 리스트를 날짜로 보여줌
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:item_];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日hh時mm分"];
    
    NSString *title = [dateFormatter stringFromDate:date];
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 선택된 셀의 정보 수집
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedLabel = cell.textLabel.text;
    NSString *title = [diaryData.allKeys objectAtIndex:indexPath.row];
    NSString *content = [diaryData.allValues objectAtIndex:indexPath.row];
    
    // 편집뷰 호출
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    Day *day = [[Day alloc] initWithTime:[title doubleValue] title:selectedLabel content:content];
    
    // 노티피케이션 호출(트리거)
    NSDictionary *notiDic = [[NSDictionary alloc] initWithObjectsAndKeys:day,@"content", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setContent" object:nil userInfo:notiDic];
}

#pragma mark - @selector

- (IBAction) setting:(id)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (IBAction) writeDiary:(id)sender {
    // 편집뷰 호출
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    NSTimeInterval now = [[NSDate alloc] init].timeIntervalSince1970;
    Day *day = [[Day alloc] initWithTime:now title:@"anTest01" content:nil];
    
    // 노티피케이션 호출(트리거)
    NSDictionary *notiDic = [[NSDictionary alloc] initWithObjectsAndKeys:day,@"content", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setContent" object:nil userInfo:notiDic];
}

#pragma mark - Table view delete row

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = [diaryData.allKeys objectAtIndex:indexPath.row];
    [diaryData removeObjectForKey:item];
    
    // 파일 저장
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *documentRootPath = [documentPaths objectAtIndex:0];
    
    NSString *stringFilePath = [documentRootPath stringByAppendingPathComponent:@"simple_diary.plist"];
    
    BOOL isWritten = NO;
    isWritten = [diaryData writeToFile:stringFilePath atomically:YES];
    
    // 테이블뷰 갱신
    //  현재 navigationController에 상위 view를 얻어와서 tableView에 접근
    [[(UITableViewController *)[self.navigationController topViewController] tableView] reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
