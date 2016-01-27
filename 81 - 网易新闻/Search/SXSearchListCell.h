//
//  SXSearchListCell.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/1/27.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXSearchListEntity.h"

@interface SXSearchListCell : UITableViewCell

@property(nonatomic,strong)SXSearchListEntity *model;
+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
