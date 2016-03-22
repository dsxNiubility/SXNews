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

@interface SXReplyPage ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)SXReplyViewModel *viewModel;

@end


@implementation SXReplyPage
static NSString *ID = @"replyCell";


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
    }
    
    if (section == 0) {
        return self.viewModel.replyModels.count;
    }else{
        return self.viewModel.replyNormalModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
     SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[SXReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.viewModel.replyModels.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     评论加载中...";
        return cell2;
    }else{
        if(indexPath.section == 0){
            SXReplyEntity *model = self.viewModel.replyModels[indexPath.row];
            cell.replyModel = model;
        }else{
            SXReplyEntity *model = self.viewModel.replyNormalModels[indexPath.row];
            cell.replyModel = model;
        }
        
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [SXReplyHeader replyViewFirst];
    }else{
        return [SXReplyHeader replyViewLast];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.viewModel.replyModels.count == 0){
        return 40;
    }else{
        SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        SXReplyEntity *model;
        if (indexPath.section == 0) {
            model = self.viewModel.replyModels[indexPath.row];
        }else{
            model = self.viewModel.replyNormalModels[indexPath.row];
        }
        cell.replyModel = model;
        
        [cell layoutIfNeeded];
        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return cell.sayLabel.frame.origin.y + size.height + 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}
@end
