//
//  SXReplyViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/22.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXReplyViewModel.h"

@interface SXReplyViewModel ()

@end

@implementation SXReplyViewModel
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
    _fetchHotReplyCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
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
                    [subscriber sendNext:temReplyModels];
                    [subscriber sendCompleted];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
    
    _fetchNormalReplyCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForPhotoNorFeedbackSuccess:^(NSDictionary *responseObject) {
                NSArray *dictarray = responseObject[@"newPosts"];
                
                NSMutableArray *temArray = [NSMutableArray array];
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
                    [temArray addObject:replyModel];
                }
                self.replyNormalModels = temArray;
                [subscriber sendNext:temArray];
                [subscriber sendCompleted];
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
    NSString *url;
    if(self.source == SXReplyPageFromNewsDetail){
        url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,self.newsModel.docid];
    }else{
        url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,self.photoSetPostID];
    }
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

- (void)requestForPhotoNorFeedbackSuccess:(void (^)(NSDictionary *result))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *url;
    if(self.source == SXReplyPageFromNewsDetail){
        url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/10/10/2/2",self.newsModel.boardid,self.newsModel.docid];
    }else{
        url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/10/10/2/2",self.newsModel.boardid,self.photoSetPostID];
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
