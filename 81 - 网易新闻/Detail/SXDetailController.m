//
//  SXDetailController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXDetailController.h"
#import "SXDetailModel.h"
#import "SXDetailImgModel.h"
#import "SXHTTPManager.h"

#import "SXReplyModel.h"
#import "SXReplyViewController.h"

@interface SXDetailController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong) SXDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;


@property(nonatomic,strong) NSMutableArray *replyModels;
@property(nonatomic,strong) NSArray *news;

// http://c.m.163.com/nc/article/AHHQIG5B00014JB6/full.html
@end

@implementation SXDetailController


- (NSMutableArray *)replyModels
{
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}


- (NSArray *)news
{
    if (_news == nil) {
        _news = [NSArray array];
        _news = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _news;
}

#pragma mark - ******************** 返回按钮
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - ******************** 首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detailModel = [SXDetailModel detailWithDict:responseObject[self.newsModel.docid]];
        [self showInWebView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
    
    //  http://comment.api.163.com/api/json/post/list/new/hot/ent2_bbs/AI1O4EEK00032DGD/0/10/10/2/2
    
//    NSString *replyURL = self.news[self.index][@"replyUrl"];
    NSString *docID = self.newsModel.docid;
    
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    
    
    [self.replyCountBtn setTitle:displayCount forState:UIControlStateNormal];
    
    NSLog(@"%@",self.news[1]);
    NSLog(@"%@----%@",self.newsModel.boardid,docID);
    
    // 假数据
//    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    
    // 真数据
    NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,docID];
    [self sendRequestWithUrl2:url2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.hidesBottomBarWhenPushed=YES;
//    }
//    return self;
//}

/** 提前把评论的请求也发出去 得到评论的信息 */
- (void)sendRequestWithUrl2:(NSString *)url
{
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        if (responseObject[@"hotPosts"] != [NSNull null]) {
            NSArray *dictarray = responseObject[@"hotPosts"];
            //        NSLog(@"%ld",dictarray.count);
            
            for (int i = 0; i < dictarray.count; i++) {
                NSDictionary *dict = dictarray[i][@"1"];
                SXReplyModel *replyModel = [[SXReplyModel alloc]init];
                replyModel.name = dict[@"n"];
                if (replyModel.name == nil) {
                    replyModel.name = @"火星网友";
                }
                replyModel.address = dict[@"f"];
                replyModel.say = dict[@"b"];
                replyModel.suppose = dict[@"v"];
                [self.replyModels addObject:replyModel];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}

#pragma mark - ******************** 拼接html语言
- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (SXDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
    
    // 设置img的div
    [imgHtml appendString:@"<div class=\"img-parent\">"];
    
    // 数组存放被切割的像素
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
                            "  window.location.href = 'sx:src=' +this.src;"
                                    "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
    // 结束标记
    [imgHtml appendString:@"</div>"];
    // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

#pragma mark - ******************** 将发出通知时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }
    return YES;
}

#pragma mark - ******************** 保存到相册方法
- (void)savePictureToAlbum:(NSString *)src
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ******************** 即将跳转时
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SXReplyViewController *replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
