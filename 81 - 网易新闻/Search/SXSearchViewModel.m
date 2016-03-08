//
//  SXSearchViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXSearchViewModel.h"
#import "NSString+Base64.h"

@implementation SXSearchViewModel

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
    _fetchHotWordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForHotWordSuccess:^(NSArray *array) {
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
    
    _fetchSearchResultListArray = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForSearchResultListArrayWithSuccess:^(NSArray *array) {
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

#pragma mark - **************** 下面相当于service的代码
- (void)requestForHotWordSuccess:(void (^)(NSArray *array))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/search/hotWord.html"];
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSArray *array = responseObject[@"hotWordList"];
        if (array) {
            success(array);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

- (void)requestForSearchResultListArrayWithSuccess:(void (^)(NSArray *array))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *searchKeyWord = [self.searchText base64encode];
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/search/comp/MA==/20/%@.html",searchKeyWord];
    
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSArray *dictArray = responseObject[@"doc"][@"result"];
        if (dictArray) {
            success(dictArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

@end
