//
//  SXPhotoSetPage.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXPhotoSetViewModel.h"
#import "SXPhotoSetPage.h"
#import "SXReplyPage.h"

@interface SXPhotoSetPage ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;

@property(nonatomic,strong) SXPhotoSetEntity *photoSet;
@property(nonatomic,strong) SXReplyEntity *replyModel;
@property(nonatomic,strong) NSMutableArray *replyModels;
@property(nonatomic,strong) NSMutableArray *replyNormalModels;
@property(nonatomic,strong) NSArray *news;
@property(nonatomic,strong)SXPhotoSetViewModel *viewModel;

@end

@implementation SXPhotoSetPage

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

- (SXPhotoSetViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[SXPhotoSetViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - ******************** lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这个页面是storyboard拖的所以一上来不用设置各种乱七八糟直接开始RAC
    RAC(self.viewModel, newsModel) = RACObserve(self, newsModel);
    RAC(self, photoSet) = [RACObserve(self.viewModel, photoSet)skip:1];
    
    @weakify(self)
    [[self.viewModel.fetchPhotoSetCommand execute:nil]subscribeNext:^(SXPhotoSetEntity *x) {
        [self setLabelWithModel:x];
        [self setImageViewWithModel:x];
    }];
    
    [[RACObserve(self.viewModel, replyCountBtnTitle)skip:1]subscribeNext:^(NSString *x) {
        @strongify(self)
        [self.replayBtn setTitle:x forState:UIControlStateNormal];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SXReplyPage *replyvc = segue.destinationViewController;
    replyvc.source = SXReplyPageFromPhotoset;
    replyvc.newsModel = self.newsModel;
    replyvc.photoSetId = self.photoSet.postid;
}

- (IBAction)backBtnClick:(id)sender {
    CFRelease((__bridge CFTypeRef)self);
    CFIndex rc = CFGetRetainCount((__bridge CFTypeRef)self);
    NSLog(@"%ld",rc);
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - ******************** UI
/** 设置页面文字 */
- (void)setLabelWithModel:(SXPhotoSetEntity *)photoSet
{
    self.titleLabel.text = photoSet.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoSet.photos.count];
    self.countLabel.text = countNum;
}

/** 设置页面imgView */
- (void)setImageViewWithModel:(SXPhotoSetEntity *)photoSet
{
    NSUInteger count = self.photoSet.photos.count;
    
//    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
//    view.frame = CGRectMake(0, 0, self.photoScrollView.contentSize.width, self.photoScrollView.contentSize.height);
//    [self.photoScrollView addSubview:view];
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        photoImgView.height = self.photoScrollView.height;
        photoImgView.width = self.photoScrollView.width;
        photoImgView.y = -64;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        [self.photoScrollView addSubview:photoImgView];
    }
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
    UIImageView *photoImgView = nil;
    if (i == 0) {
        photoImgView = self.photoScrollView.subviews[i+2];
    }else{
        photoImgView = self.photoScrollView.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:[self.photoSet.photos[i] imgurl]];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
//        [photoImgView sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
        
        [photoImgView sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIColor *color = [self mostColor:photoImgView.image];
            self.photoScrollView.backgroundColor = color;
        }];
    }
}

static void RGBtoHSV( float r, float g, float b, float *h, float *s,float *v)
{
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;       // s
    else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;     // between yellow & magenta
    else if( g == max )
        *h = 2 + ( b - r ) / delta; // between cyan & yellow
    else
        *h = 4 + ( r - g ) / delta; // between magenta & cyan
    *h *= 60;               // degrees
    if( *h < 0 )
        *h += 360;
}

-(UIColor*)mostColor:(UIImage*)image{
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;

    //先把图片缩小
    CGSize thumbSize=CGSizeMake(40, 40);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    NSArray *MaxColor=nil;
    // NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    float maxScore=0;
    for (int x=0; x<thumbSize.width*thumbSize.height; x++) {
        
        int offset = 4*x;
        
        int red = data[offset];
        int green = data[offset+1];
        int blue = data[offset+2];
        int alpha =  data[offset+3];
        
        if (alpha<25)continue;
        
        float h,s,v;
        RGBtoHSV(red, green, blue, &h, &s, &v);

        float y = MIN(abs(red*2104+green*4130+blue*802+4096+131072)>>13, 235);
        y= (y-16)/(235-16);
        if (y>0.9) continue;
        
        float score = (s+0.1)*x;
        if (score>maxScore) {
            maxScore = score;
        }
        MaxColor=@[@(red),@(green),@(blue),@(alpha)];
        //[cls addObject:clr];
    }
    CGContextRelease(context);
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:(0.2)];
}

@end
