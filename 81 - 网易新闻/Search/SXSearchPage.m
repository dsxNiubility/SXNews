//
//  SXSearchPage.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/1/26.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXSearchPage.h"
#import "UIView+Frame.h"
#import "NSString+Base64.h"
#import "SXSearchListEntity.h"

@interface SXSearchPage ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *beginView;

@property(nonatomic,strong)NSArray<SXSearchListEntity *> *searchListArray;

@end

@implementation SXSearchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/search/hotWord.html"];
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    NSLog(@"%@",searchBar.text);
    if (self.beginView.superview) {
        [self.beginView removeFromSuperview];
    }
    [searchBar resignFirstResponder];
    
    NSString *searchKeyWord = [searchBar.text base64encode];
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/search/comp/MA==/20/%@.html",searchKeyWord];
    
    __weak SXSearchPage *weakSelf = self;
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSArray *dictArray = responseObject[@"doc"][@"result"];
        weakSelf.searchListArray = [SXSearchListEntity objectArrayWithKeyValuesArray:dictArray];
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
