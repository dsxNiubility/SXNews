//
//  SXReplyCell.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXReplyEntity.h"

@interface SXReplyCell : UITableViewCell

@property(nonatomic,strong) SXReplyEntity *replyModel;
/** 用户的发言 */
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;
@end
