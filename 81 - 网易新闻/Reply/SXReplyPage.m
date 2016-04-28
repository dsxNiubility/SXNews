//
//  SXReplyPage.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXReplyPage.h"
#import "SXReplyHeader.h"
#import "SXReplyCell.h"
#import "SXReplyEntity.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface SXReplyPage ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)SXReplyViewModel *viewModel;

@end


@implementation SXReplyPage
static NSString *ID = @"SXReplyCell";


#pragma mark - **************** lifeCycle
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[self.viewModel.fetchHotReplyCommand execute:nil]subscribeError:^(NSError *error) {
        NSLog(@"error occured! --%@",error.userInfo);
    } completed:^{
        [self.tableView reloadData];
    }];
    
    [[self.viewModel.fetchNormalReplyCommand execute:nil]subscribeError:^(NSError *error) {
        NSLog(@"error occured! --%@",error.userInfo);
    } completed:^{
        [self.tableView reloadData];
    }];
}

- (SXReplyViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[SXReplyViewModel alloc]init];
        RAC(self.viewModel,source) = RACObserve(self, source);
        RAC(self.viewModel,newsModel) = RACObserve(self, newsModel);
        RAC(self.viewModel,photoSetPostID) = RACObserve(self, photoSetId);
    }
    return _viewModel;
}

#pragma mark - ******************** about tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.replyModels.count == 0) {
        return 1;
    }else{
        return section == 0 ? self.viewModel.replyModels.count:self.viewModel.replyNormalModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.replyModels.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     评论加载中...";
        return cell2;
    }else{
        SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[SXReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return section == 0?[SXReplyHeader replyViewFirst]:[SXReplyHeader replyViewLast];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.viewModel.replyModels.count == 0){
        return 40;
    }else{
        return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(SXReplyCell *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
}

- (void)configureCell:(SXReplyCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    SXReplyEntity *model;
    if (indexPath.section == 0) {
        model = self.viewModel.replyModels[indexPath.row];
    }else{
        model = self.viewModel.replyNormalModels[indexPath.row];
    }
    cell.replyModel = model;
}

@end
