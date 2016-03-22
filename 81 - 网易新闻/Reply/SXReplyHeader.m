//
//  SXReplyHeader.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXReplyHeader.h"

@implementation SXReplyHeader

/** 类方法快速返回热门跟帖的view */
+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SXReplyHeader" owner:nil options:nil];
    return [array firstObject];
}

/** 类方法快速返回最新跟帖的view */
+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SXReplyHeader" owner:nil options:nil];
    return [array lastObject];
}

@end
