//
//  SXNewsDetailBottomCell.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/1/29.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXNewsDetailBottomCell.h"

@interface SXNewsDetailBottomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *userLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodLbl;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLbl;
@property (weak, nonatomic) IBOutlet UILabel *replyDetail;


@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsFromLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLbl;



@end
@implementation SXNewsDetailBottomCell

+ (instancetype)theShareCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SXNewsDetailBottomCell" owner:nil options:nil][0];
}

+ (instancetype)theSectionHeaderCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SXNewsDetailBottomCell" owner:nil options:nil][1];
}

+ (instancetype)theSectionBottomCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SXNewsDetailBottomCell" owner:nil options:nil][2];
}

+ (instancetype)theHotReplyCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SXNewsDetailBottomCell" owner:nil options:nil][3];
}

+ (instancetype)theContactNewsCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SXNewsDetailBottomCell" owner:nil options:nil][5];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
