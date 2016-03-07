//
//  SXNewsDetailEntity.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXNewsDetailEntity.h"
#import "SXDetailImgEntity.h"
@implementation SXNewsDetailEntity

/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    SXNewsDetailEntity *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    detail.replyBoard = dict[@"replyBoard"];
    detail.replyCount = [dict[@"replyCount"] integerValue];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        SXDetailImgEntity *imgModel = [SXDetailImgEntity detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}

@end
