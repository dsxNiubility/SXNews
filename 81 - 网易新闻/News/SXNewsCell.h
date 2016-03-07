//
//  SXNewsCell.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNewsEntity.h"

@interface SXNewsCell : UITableViewCell

@property(nonatomic,strong) SXNewsEntity *NewsModel;



/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(SXNewsEntity *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(SXNewsEntity *)NewsModel;
@end
