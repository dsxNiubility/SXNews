//
//  SXCollectionCell.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTableViewController.h"

@interface SXCollectionCell : UICollectionViewCell

@property(nonatomic,copy) NSString *urlString;
@property(nonatomic,strong) UINavigationController *nav;
@property(nonatomic,strong) SXTableViewController *TbVc;
@end
