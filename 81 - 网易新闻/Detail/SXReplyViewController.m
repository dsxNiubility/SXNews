//
//  SXReplyViewController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXReplyViewController.h"
#import "SXReplyHeader.h"
#import "SXReplyCell.h"

@interface SXReplyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end


@implementation SXReplyViewController
static NSString *ID = @"replyCell";

#pragma mark - ******************** 返回按钮
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - ******************** tbv数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (self.replys.count == 0) {
        return 1;
    }
    
    if (section == 0) {
        return self.replys.count;
    }else{
        return self.replys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
     SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[SXReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.replys.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     暂无跟帖数据";
        return cell2;
    }else{
        SXReplyModel *model = self.replys[indexPath.row];
        cell.replyModel = model;
    }
    
    return cell;
}
/** 返回一个view来当tbv的header */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [SXReplyHeader replyViewFirst];
    }else{
        return [SXReplyHeader replyViewLast];
    }
}

/** 通过提前计算来返回行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.replys.count == 0){
        return 40;
    }else{
        SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        SXReplyModel *model = self.replys[indexPath.row];
        
        cell.replyModel = model;
        
        [cell layoutIfNeeded];
        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return cell.sayLabel.frame.origin.y + size.height + 10;
    }
}

/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}
@end
