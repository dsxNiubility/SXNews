//
//  SXReplyHeader.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXReplyHeader.h"

@implementation SXReplyHeader


+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SXReplyHeader" owner:nil options:nil];
    return [array firstObject];
}

+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SXReplyHeader" owner:nil options:nil];
    return [array lastObject];
}

@end
