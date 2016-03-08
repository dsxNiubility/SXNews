//
//  SXNewsDetailViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXNewsDetailViewModel.h"

@implementation SXNewsDetailViewModel

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
    _fetchNewsDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForNewsDetailSuccess:^(NSDictionary *result) {
                
                self.detailModel = [SXNewsDetailEntity detailWithDict:result[self.newsModel.docid]];
                if (self.newsModel.boardid.length < 1) {
                    self.newsModel.boardid = self.detailModel.replyBoard;
                }
                self.newsModel.replyCount = @(self.detailModel.replyCount);
                
                self.sameNews = [SXSimilarNewsEntity objectArrayWithKeyValuesArray:result[self.newsModel.docid][@"relative_sys"]];
                self.keywordSearch = result[self.newsModel.docid][@"keyword_search"];
                
                CGFloat count =  [self.newsModel.replyCount intValue];
                if (count > 10000) {
                    self.replyCountBtnTitle = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
                }else{
                    self.replyCountBtnTitle = [NSString stringWithFormat:@"%.0f跟帖",count];
                }
                [subscriber sendNext:self.replyCountBtnTitle];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
    
    _fetchFeedbackCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForFeedbackSuccess:^(NSDictionary *responseObject) {
                if (responseObject[@"hotPosts"] != [NSNull null]) {
                    NSArray *dictarray = responseObject[@"hotPosts"];
                    NSMutableArray *temReplyModels = [NSMutableArray array];
                    for (int i = 0; i < dictarray.count; i++) {
                        NSDictionary *dict = dictarray[i][@"1"];
                        SXReplyEntity *replyModel = [[SXReplyEntity alloc]init];
                        replyModel.name = dict[@"n"];
                        if (replyModel.name == nil) {
                            replyModel.name = @"火星网友";
                        }
                        replyModel.address = dict[@"f"];
                        replyModel.say = dict[@"b"];
                        replyModel.suppose = dict[@"v"];
                        replyModel.icon = dict[@"timg"];
                        replyModel.rtime = dict[@"t"];
                        [temReplyModels addObject:replyModel];
                    }
                    self.replyModels = temReplyModels;
                    [subscriber sendCompleted];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

#pragma mark - **************** 下面相当于service的代码
- (void)requestForFeedbackSuccess:(void (^)(NSDictionary *result))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    // 真数据
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,self.newsModel.docid];
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];

}

- (void)requestForNewsDetailSuccess:(void (^)(NSDictionary *result))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

@end
