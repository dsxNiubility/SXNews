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

@property(nonatomic,strong) NSArray *replyArray;

@end


@implementation SXReplyViewController
static NSString *ID = @"replyCell";
- (NSArray *)replyArray
{
    if (_replyArray == nil) {
        _replyArray = [NSArray array];
        _replyArray = @[@"你这个懦弱的狗杂碎",@"殚精竭虑的詹秃",@"关你皮仕",@"如果这都找不到",@"我要杀了你",@"自备簪子铁锹手枪钻冲击钻等",@"茎关其便",@"大黄讨厌西部",@"表哥来啦！有煞笔阉狗要砍我",@"今天你对我爱理不理",@"明天我让你高攀不起",@"关你皮仕"];
    }
    return _replyArray;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.contentOffset = CGPointMake(0, 50);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.replys.count;
    }else{
        return self.replyArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
     SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[SXReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    SXReplyModel *model = self.replys[indexPath.row];
    cell.replyModel = model;
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
    SXReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    SXReplyModel *model = self.replys[indexPath.row];
    
    cell.replyModel = model;
    
    [cell layoutIfNeeded];
    CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return cell.sayLabel.frame.origin.y + size.height + 10;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}
@end
