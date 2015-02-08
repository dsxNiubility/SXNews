//
//  SXPhotosDetail.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXPhotosDetail.h"

@implementation SXPhotosDetail

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    SXPhotosDetail *photoDetail = [[SXPhotosDetail alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    
    return photoDetail;
}

@end
