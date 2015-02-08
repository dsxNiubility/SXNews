//
//  SXDetailImgModel.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXDetailImgModel.h"

@implementation SXDetailImgModel

+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    SXDetailImgModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}

@end
