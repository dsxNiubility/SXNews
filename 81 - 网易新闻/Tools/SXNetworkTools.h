//
//  SXNetworkTools.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SXNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
