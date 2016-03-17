//
//  MJExtensionConfig.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/10.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "SXWeatherEntity.h"
#import "SXPhotoSetEntity.h"

@implementation MJExtensionConfig
+ (void)load
{

    [SXWeatherEntity setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"detailArray" : @"SXWeatherDetailEntity"
                 };
    }];
    // 相当于在StatusResult.m中实现了+objectClassInArray方法
    
    // Student中的ID属性对应着字典中的id
    // ....
    [SXWeatherEntity setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"detailArray" : @"北京|北京"
                 };
    }];
    // 相当于在Student.m中实现了+replacedKeyFromPropertyName方法
    
    [SXPhotoSetEntity setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"photos":@"SXPhotosDetailEntity"
                 };
    }];
}
@end
