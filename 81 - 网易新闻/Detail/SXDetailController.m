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
#import "SXNewsDetailBottomCell.h"
#import "SXSameNewsEntity.h"
#import "SXSearchPage.h"

#define NewsDetailControllerClose (self.tableView.contentOffset.y - (self.tableView.contentSize.height - SXSCREEN_H + 55) > (100 - 54))

@interface SXDetailController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property(nonatomic,strong) SXDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)SXNewsDetailBottomCell *closeCell;

@property(nonatomic,strong) NSMutableArray *replyModels;
/** 相似新闻*/
@property(nonatomic,strong)NSArray *sameNews;
/** 搜索关键字*/
@property(nonatomic,strong)NSArray *keywordSearch;

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

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 700)];
        _webView = web;
    }
    return _webView;
}

#pragma mark - ******************** 返回按钮
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - ******************** 首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 300)];
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detailModel = [SXDetailModel detailWithDict:responseObject[self.newsModel.docid]];
        if (self.newsModel.boardid.length < 1) {
            self.newsModel.boardid = self.detailModel.replyBoard;
        }
        self.newsModel.replyCount = @(self.detailModel.replyCount);
        [self showInWebView];
        // 真数据
        NSString *docID = self.newsModel.docid;
        NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,docID];
        [self sendRequestWithUrl2:url2];
        
        self.sameNews = [SXSameNewsEntity objectArrayWithKeyValuesArray:responseObject[self.newsModel.docid][@"relative_sys"]];
        self.keywordSearch = responseObject[self.newsModel.docid][@"keyword_search"];
        
        CGFloat count =  [self.newsModel.replyCount intValue];
        NSString *displayCount;
        if (count > 10000) {
            displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
        }else{
            displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
        }
        [self.replyCountBtn setTitle:displayCount forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
//  http://comment.api.163.com/api/json/post/list/new/hot/ent2_bbs/AI1O4EEK00032DGD/0/10/10/2/2
//    NSString *replyURL = self.news[self.index][@"replyUrl"];
//    NSLog(@"%@",self.news[1]);
//    NSLog(@"%@----%@",self.newsModel.boardid,docID);
// 假数据
//    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
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
                replyModel.icon = dict[@"timg"];
                replyModel.rtime = dict[@"t"];
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
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.height = self.webView.scrollView.contentSize.height;
    [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.webView;
    }else if (section == 1){
        SXNewsDetailBottomCell *head = [SXNewsDetailBottomCell theSectionHeaderCell];
        head.sectionHeaderLbl.text = @"热门跟帖";
        return head;
    }else if (section == 2){
        SXNewsDetailBottomCell *head = [SXNewsDetailBottomCell theSectionHeaderCell];
        head.sectionHeaderLbl.text = @"相关新闻";
        return head;
    }
    return [UIView new];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.webView.height;
    }else if (section == 1){
        return self.replyModels.count > 0 ? 40 : CGFLOAT_MIN;
    }else if (section == 2){
        return self.sameNews.count > 0 ? 40 : CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2){
        SXNewsDetailBottomCell *closeCell = [SXNewsDetailBottomCell theCloseCell];
        self.closeCell = closeCell;
        return closeCell;
    }
    return [[UIView alloc]init];
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2){
        return 64;
    }
    return 15;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1 + self.replyModels.count;
    }else if (section == 2){
        return self.sameNews.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == self.replyModels.count) {
            [self performSegueWithIdentifier:@"toReply" sender:nil];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row > 0) {
            SXNewsModel *model = [[SXNewsModel alloc]init];
            model.docid = [self.sameNews[indexPath.row] id];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
            SXDetailController *devc = (SXDetailController *)[sb instantiateViewControllerWithIdentifier:@"SXDetailController"];
            devc.newsModel = model;
            [self.navigationController pushViewController:devc animated:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [SXNewsDetailBottomCell theShareCell];
    }else if (indexPath.section == 1){
        if (indexPath.row == self.replyModels.count) {
            SXNewsDetailBottomCell *foot = [SXNewsDetailBottomCell theSectionBottomCell];
            return foot;
        }else{
            SXNewsDetailBottomCell *hotreply = [SXNewsDetailBottomCell theHotReplyCellWithTableView:tableView];
            hotreply.replyModel = self.replyModels[indexPath.row];
            return hotreply;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            SXNewsDetailBottomCell *cell = [SXNewsDetailBottomCell theKeywordCell];
            [cell.contentView addSubview:[self addKeywordButton]];
            return cell;
        }else{
            SXNewsDetailBottomCell *other = [SXNewsDetailBottomCell theContactNewsCell];
            other.sameNewsEntity = self.sameNews[indexPath.row];
            return other;
        }
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 126;
    }else if (indexPath.section == 1){
        if (indexPath.row == self.replyModels.count) {
            return 50;
        }else{
            return 110.5;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 81;
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 126;
    }else if (indexPath.section == 1){
        if (indexPath.row == self.replyModels.count) {
            return 50;
        }else{
            return 110.5;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 81;
        }
    }
    return CGFLOAT_MIN;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.closeCell) {
        self.closeCell.iSCloseing = NewsDetailControllerClose;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"松手了%f--%f",self.tableView.contentOffset.y,self.tableView.contentSize.height - SXSCREEN_H + 55);
    if (NewsDetailControllerClose) {
        UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SXSCREEN_W, SXSCREEN_H)];
        imgV.image = [self getImage];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:imgV];
        [self.navigationController popViewControllerAnimated:NO];
        imgV.alpha = 1.0;
        [UIView animateWithDuration:0.3 animations:^{
            imgV.frame = CGRectMake(0, SXSCREEN_H/2, SXSCREEN_W, 0);
            imgV.alpha = 0.0;
        } completion:^(BOOL finished) {
            [imgV removeFromSuperview];
        }];
    }
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (UIView *)addKeywordButton
{
    CGFloat maxRight = 20;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 60)];
    for (int i = 0;i<self.keywordSearch.count ; ++i) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(maxRight, 10, 0, 0)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:SXRGBColor(74, 133, 198) forState:UIControlStateNormal];
        [button setTitle:self.keywordSearch[i][@"word"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"choose_city_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"choose_city_highlight"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.width += 20;
        button.height = 35;
        [button addTarget:self action:@selector(keywordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        maxRight = button.x + button.width + 10;
        [view addSubview:button];
    }
    return view;
}

- (void)keywordButtonClick:(UIButton *)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SXSearchPage *sp = [sb instantiateViewControllerWithIdentifier:@"SXSearchPage"];
    sp.keyword = sender.titleLabel.text;
    [self.navigationController pushViewController:sp animated:YES];
}

- (UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SXSCREEN_W, SXSCREEN_H), NO, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
