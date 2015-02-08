//
//  SXNewsCell.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNewsModel.h"

@interface SXNewsCell : UITableViewCell

@property(nonatomic,strong) SXNewsModel *NewsModel;



/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(SXNewsModel *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(SXNewsModel *)NewsModel;
@end
