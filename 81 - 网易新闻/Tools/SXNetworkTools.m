//
//  SXNetworkTools.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXNetworkTools.h"

@implementation SXNetworkTools

+ (instancetype)sharedNetworkTools
{
    static SXNetworkTools*instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // http://c.m.163.com//nc/article/list/T1348649654285/0-20.html
        // http://c.m.163.com/photo/api/set/0096/57255.json
        // http://c.m.163.com/photo/api/set/54GI0096/57203.html
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

+ (instancetype)sharedNetworkToolsWithoutBaseUrl
{
    static SXNetworkTools*instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@""];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

@end
