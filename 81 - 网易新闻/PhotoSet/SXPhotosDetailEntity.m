//
//  SXPhotosDetailEntity.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXPhotosDetailEntity.h"

@implementation SXPhotosDetailEntity

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    SXPhotosDetailEntity *photoDetail = [[SXPhotosDetailEntity alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    
    return photoDetail;
}

@end
