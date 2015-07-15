//
//  SXTableViewController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXTableViewController.h"
#import "SXDetailController.h"
#import "SXPhotoSetController.h"
#import "SXNewsCell.h"
#import "SXNetworkTools.h"
#import "MJRefresh.h"

@interface SXTableViewController ()

@property(nonatomic,strong) NSArray *arrayList;
@property(nonatomic,assign)BOOL update;

@end

@implementation SXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self loadData];
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.update = YES;
//    self.tableView.headerHidden = NO;
}

- (void)setArrayList:(NSArray *)arrayList
{
    _arrayList = arrayList;
    
    [self.tableView reloadData];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
//    [self loadData];
//    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"bbbb");
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

#pragma mark - /************************* 刷新数据 ***************************/
- (void)loadData
{
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
//    NSLog(@"%@",self.urlString);
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [[[SXNetworkTools sharedNetworkTools]GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:temArray.count];
        [temArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SXNewsModel *news = [SXNewsModel newsModelWithDict:obj];
            [arrayM addObject:news];
        }];
        self.arrayList = arrayM;
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];

}

// ------下拉刷新就先这么写了，以前写的不规范现在也搞不规范了。
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    [[[SXNetworkTools sharedNetworkTools]GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:temArray.count];
        [temArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SXNewsModel *news = [SXNewsModel newsModelWithDict:obj];
            [arrayM addObject:news];
        }];
//        self.arrayList = arrayM;
        NSMutableArray *allList = [NSMutableArray array];
        [allList addObjectsFromArray:self.arrayList];
        [allList addObjectsFromArray:arrayM];
//        NSLog(@"%ld",self.arrayList.count);
        self.arrayList = allList;
//        NSLog(@"%ld",self.arrayList.count);
        
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}

#pragma mark - /************************* tbv数据源方法 ***************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXNewsModel *newsModel = self.arrayList[indexPath.row];
    
    NSString *ID = [SXNewsCell idForRow:newsModel];
    
    SXNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.NewsModel = newsModel;
    
    return cell;
    
}

#pragma mark - /************************* tbv代理方法 ***************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXNewsModel *newsModel = self.arrayList[indexPath.row];
    
    return [SXNewsCell heightForRow:newsModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SXDetailController class]]) {
        
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        SXDetailController *dc = segue.destinationViewController;
        dc.newsModel = self.arrayList[x];
        dc.index = self.index;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        SXPhotoSetController *pc = segue.destinationViewController;
        pc.newsModel = self.arrayList[x];
        
        
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

@end