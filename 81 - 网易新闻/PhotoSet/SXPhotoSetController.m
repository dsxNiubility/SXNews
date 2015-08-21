//
//  SXPhotoSetController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXPhotoSetController.h"
#import "UIImageView+WebCache.h"


#import "SXHTTPManager.h"
#import "SXPhotoSet.h"
#import "SXPhotosDetail.h"
#import "UIView+Frame.h"

#import "SXReplyModel.h"
#import "SXReplyViewController.h"

#import "MJExtension.h"

@interface SXPhotoSetController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;

@property(nonatomic,strong) SXPhotoSet *photoSet;

@property(nonatomic,strong) SXReplyModel *replyModel;
@property(nonatomic,strong) NSMutableArray *replyModels;

@property(nonatomic,strong) NSArray *news;


@end

@implementation SXPhotoSetController
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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
    return _replyModels;
}

#pragma mark - ******************** 首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    
    // 取出关键字
    NSString *one  = self.newsModel.photosetID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    
    [self.replayBtn setTitle:displayCount forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    // 发请求
    [self sendRequestWithUrl:url];
    
     //  http://comment.api.163.com/api/json/post/list/new/hot/tech_bbs/AI180I93000915BF/
    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    [self sendRequestWithUrl2:url2];
    }

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - ******************** 发请求
- (void)sendRequestWithUrl:(NSString *)url
{
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        SXPhotoSet *photoSet = [SXPhotoSet photoSetWith:responseObject];
        SXPhotoSet *photoSet = [SXPhotoSet objectWithKeyValues:responseObject];
        self.photoSet = photoSet;
        
        [self setLabelWithModel:photoSet];
        
        [self setImageViewWithModel:photoSet];
        
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];

}

/** 提前把评论的请求也发出去 得到评论的信息 */
- (void)sendRequestWithUrl2:(NSString *)url
{
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}

#pragma mark - ******************** 设置页面的文字和图片

/** 设置页面文字 */
- (void)setLabelWithModel:(SXPhotoSet *)photoSet
{
    self.titleLabel.text = photoSet.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoSet.photos.count];
    self.countLabel.text = countNum;
}

/** 设置页面imgView */
- (void)setImageViewWithModel:(SXPhotoSet *)photoSet
{
    NSUInteger count = self.photoSet.photos.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        photoImgView.height = self.photoScrollView.height;
        photoImgView.width = self.photoScrollView.width;
        photoImgView.y = -64;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeCenter;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        [self.photoScrollView addSubview:photoImgView];
        
    }
    
    // 因为scroll尼玛默认就有两个子控件好吧
    [self setImgWithIndex:0];
    
    self.photoScrollView.contentOffset = CGPointZero;
    self.photoScrollView.contentSize = CGSizeMake(self.photoScrollView.width * count, 0);
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoScrollView.pagingEnabled = YES;
}

/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScrollView.contentOffset.x / self.photoScrollView.width;
    
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.photoSet.photos.count];
    self.countLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}

/** 添加内容 */
- (void)setContentWithIndex:(int)index
{
    NSString *content = [self.photoSet.photos[index] note];
    NSString *contentTitle = [self.photoSet.photos[index] imgtitle];
    if (content.length != 0) {
        self.contentText.text = content;
    }else{
        self.contentText.text = contentTitle;
    }
}

/** 懒加载添加图片！这里才是设置图片 */
- (void)setImgWithIndex:(int)i
{
    // 这里不要问我为什么这么写因为尼玛就是有bug
    UIImageView *photoImgView = nil;
    if (i == 0) {
        photoImgView = self.photoScrollView.subviews[i+2];
    }else{
        photoImgView = self.photoScrollView.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:[self.photoSet.photos[i] imgurl]];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SXReplyViewController *replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
}



@end
