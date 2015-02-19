//
//  SXReplyCell.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXReplyCell.h"

@interface SXReplyCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *supposeLabel;
@property (nonatomic,assign) CGFloat maxY;


@end

@implementation SXReplyCell


- (void)setReplyModel:(SXReplyModel *)replyModel
{
    _replyModel = replyModel;
    self.nameLabel.text = _replyModel.name;
    self.addressLabel.text = _replyModel.address;
    self.sayLabel.text = _replyModel.say;
    self.supposeLabel.text = _replyModel.suppose;
}


- (void)awakeFromNib {
    
}

@end
