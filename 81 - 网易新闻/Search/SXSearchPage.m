//
//  SXSearchPage.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/1/26.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXSearchPage.h"
#import "SXSearchListCell.h"
#import "SXDetailPage.h"
#import "SXSearchViewModel.h"
#import "SXNewsEntity.h"

@interface SXSearchPage ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *beginView;
@property (weak, nonatomic) IBOutlet UIScrollView *hotWordView;
@property(nonatomic,assign)CGFloat maxRight;
@property(nonatomic,assign)CGFloat maxBottom;
@property(nonatomic,strong)NSArray<SXSearchListEntity *> *searchListArray;
@property(nonatomic,strong)NSArray *hotwordArray;
@property(nonatomic,strong)SXSearchViewModel *viewModel;

@end

@implementation SXSearchPage

#pragma mark - **************** lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.hotWordView.bounces = YES;
    self.maxRight = 0;
    self.maxBottom = 10;
    self.hotWordView.contentSize = self.hotWordView.frame.size;
    self.hotWordView.showsHorizontalScrollIndicator = NO;
    self.hotWordView.showsVerticalScrollIndicator = NO;
    if (self.keyword.length > 0) {
        self.searchBar.text = self.keyword;
        [self searchBarSearchButtonClicked:self.searchBar];
    }
    RAC(self.viewModel,searchText) = RACObserve(self.searchBar ,text);
    [self requestForHotWord];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

#pragma mark - **************** lazy
- (SXSearchViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[SXSearchViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - **************** tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXSearchListCell *cell = [SXSearchListCell cellWithTableView:tableView];
    cell.model = self.searchListArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"SXSearchListCell" owner:nil options:nil][1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXNewsEntity *model = [[SXNewsEntity alloc]init];
    model.docid = [self.searchListArray[indexPath.row] docid];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    SXDetailPage *devc = (SXDetailPage *)[sb instantiateViewControllerWithIdentifier:@"SXDetailPage"];
    devc.newsModel = model;
    [self.navigationController pushViewController:devc animated:YES];
}

#pragma mark - **************** searchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    NSLog(@"%@",searchBar.text);
    [searchBar resignFirstResponder];
    
    @weakify(self);
    [[self.viewModel.fetchSearchResultListArray execute:nil]subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.searchListArray = [SXSearchListEntity objectArrayWithKeyValuesArray:x];
        [self.tableView reloadData];
        self.beginView.hidden = YES;
        self.tableView.hidden = NO;
    } error:^(NSError *error) {
        // 暂时不作操作
    }];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchBar setText:searchText];
    if (searchText.length < 1) {
        self.tableView.hidden = YES;
        self.beginView.hidden = NO;
    }
}

#pragma mark - **************** other
- (void)requestForHotWord
{
    @weakify(self);
    [[self.viewModel.fetchHotWordCommand execute:nil]subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.hotwordArray = x;
        [self addHotWordInHotWordView];
    } error:^(NSError *error) {
        // 错误暂时先不管了
    }];
}

- (void)addHotWordInHotWordView
{
    for (NSDictionary *dict in self.hotwordArray) {
        [self addKeyWordBtnWithTitle:dict[@"hotWord"]];
    }
}

- (void)addKeyWordBtnWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.maxRight, self.maxBottom, 0, 0)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = SXRGBColor(220, 220, 220).CGColor;
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    [button sizeToFit];
    
    button.width += 15;
    button.height = 34 ;

    RACSignal *btnSignal = [[button rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(UIButton *btn) {
        return btn.currentTitle;
    }];
    [self rac_liftSelector:@selector(buttonClick:) withSignalsFromArray:@[btnSignal]];
    
    [self.hotWordView addSubview:button];
    self.maxRight = button.width + button.x + 10;
    
    if (self.maxRight > self.hotWordView.width) {
        self.maxRight = 0;
        self.maxBottom += 48;
        button.x = self.maxRight;
        button.y = self.maxBottom;
        self.maxRight = button.width + button.x + 10;
    }
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonClick:(NSString *)senderTitle
{
    self.searchBar.text = senderTitle;
    [self searchBarSearchButtonClicked:self.searchBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
