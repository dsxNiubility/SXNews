//
//  SXNewsDetailViewModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXNewsDetailViewModel.h"
#import "SXDetailImgEntity.h"
#import "SXReplyViewModel.h"

@interface SXNewsDetailViewModel ()
/**
 *  引用回复的viewModel
 */
@property(nonatomic,strong)SXReplyViewModel *replyViewModel;

@end

@implementation SXNewsDetailViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (SXReplyViewModel *)replyViewModel
{
    if(!_replyViewModel){
        _replyViewModel = [[SXReplyViewModel alloc]init];
        _replyViewModel.source = SXReplyPageFromNewsDetail;
        RAC(self.replyViewModel, newsModel) = RACObserve(self, newsModel);
    }
    return _replyViewModel;
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
    
    _fetchHotFeedbackCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // 嵌套replyModel使用
            [[self.replyViewModel.fetchHotReplyCommand execute:nil]subscribeNext:^(id x) {
                self.replyModels = x;
            } error:^(NSError *error) {
                [subscriber sendError:error];
            } completed:^{
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
}

#pragma mark - **************** 下面相当于service的代码
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

#pragma mark - **************** 业务逻辑
- (NSString *)getHtmlString
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:[self getBodyString]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return html;
}

- (NSString *)getBodyString
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    for (SXDetailImgEntity *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx://github.com/dsxNiubility?src=' +this.src+'&top=' + this.getBoundingClientRect().top + '&whscale=' + this.clientWidth/this.clientHeight ;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        [imgHtml appendString:@"</div>"];
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

@end
