//
//  SXNewsEntity.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXNewsEntity.h"

@implementation SXNewsEntity

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    SXNewsEntity *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
