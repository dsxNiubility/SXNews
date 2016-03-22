//
//  SXPhotoSetViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXPhotoSetViewModel.h"

@implementation SXPhotoSetViewModel
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
    _fetchPhotoSetCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForPhotoSetSuccess:^(NSDictionary *responseObject) {
                SXPhotoSetEntity *photoSet = [SXPhotoSetEntity objectWithKeyValues:responseObject];
                self.photoSet = photoSet;
                [subscriber sendNext:photoSet];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

#pragma mark - **************** 下面相当于service的代码
- (void)requestForPhotoSetSuccess:(void (^)(NSDictionary *result))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    // 取出关键字
    NSArray *parameters = [[self.newsModel.photosetID substringFromIndex:4] componentsSeparatedByString:@"|"];
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[parameters firstObject],[parameters lastObject]];
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    if (count > 10000) {
        self.replyCountBtnTitle = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        self.replyCountBtnTitle = [NSString stringWithFormat:@"%.0f跟帖",count];
    }

    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

@end
