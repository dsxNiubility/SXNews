//
//  SXCollectionCell.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXCollectionCell.h"

@interface SXCollectionCell ()



@end

@implementation SXCollectionCell

- (void)awakeFromNib
{
    // 从sb里取控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.nav = sb.instantiateInitialViewController;
    
    for (UIViewController *vc in self.nav.viewControllers) {
        if ([vc isKindOfClass:[SXTableViewController class]]) {
            self.TbVc = (SXTableViewController *)vc;
        }
    }
    
    [self addSubview:self.nav.view];
    
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    self.TbVc.urlString = urlString;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nav.view.frame = self.bounds;
}

@end
