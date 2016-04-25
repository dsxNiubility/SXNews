//
//  SXNewsViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXNewsViewModel.h"
#import "SXNewsEntity.h"

@implementation SXNewsViewModel
- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchNewsEntityCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForNewsEntityWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM = [SXNewsEntity objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (void)requestForNewsEntityWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *fullUrl = [@"http://c.m.163.com/" stringByAppendingString:url];
    [[SXHTTPManager manager]GET:fullUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        success(temArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
@end
