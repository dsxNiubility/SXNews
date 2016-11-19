//
//  SXNetworkTools.h
//  SXNews
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SXNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
