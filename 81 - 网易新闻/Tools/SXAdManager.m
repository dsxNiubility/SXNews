//
//  SXAdManager.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/9/27.
//  Copyright © 2015年 ShangxianDante. All rights reserved.
//

#import "SXAdManager.h"
#import "SXNetworkTools.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])

@interface SXAdManager ()

+ (void)downloadImage:(NSString *)imageUrl;

@end

@implementation SXAdManager

+ (BOOL)isShouldDisplayAd
{
    return ([[NSFileManager defaultManager]fileExistsAtPath:kCachedCurrentImage isDirectory:NULL] || [[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL
]);
}

+ (UIImage *)getAdImage
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL]) {
        [[NSFileManager defaultManager]removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager]moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+ (void)downloadImage:(NSString *)imageUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }
    }];
    [task resume];
}

+ (void)loadLatestAdImage
{
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    
    [[[SXNetworkTools sharedNetworkToolsWithoutBaseUrl]GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        
        NSArray *adArray = [responseObject valueForKey:@"ads"];
        NSString *imgUrl = adArray[0][@"res_url"][0];
        NSString *imgUrl2 = nil;
        if (adArray.count >1) {
             imgUrl2= adArray[1][@"res_url"][0];
        }
        
        BOOL one = [[NSUserDefaults standardUserDefaults]boolForKey:@"one"];
        if (imgUrl2.length > 0) {
            if (one) {
                [self downloadImage:imgUrl];
                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
            }else{
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
            }
        }else{
            [self downloadImage:imgUrl];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}

@end