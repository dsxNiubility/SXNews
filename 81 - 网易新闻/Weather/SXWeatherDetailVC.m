//
//  SXWeatherDetailVC.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherDetailVC.h"
#import "UIView+Frame.h"
#import "SXWeatherItemView.h"

#define W [UIScreen mainScreen].bounds.size.width

@interface SXWeatherDetailVC ()
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation SXWeatherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bottomView = [[UIView alloc]init];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    bottomView.height = 250;
    bottomView.width = W;
    bottomView.x = 0;
    bottomView.y = [UIScreen mainScreen].bounds.size.height - bottomView.height;
    bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    [self addItemWithTitle:@"星期日" weather:@"多云" wind:@"微风" T:@" 36°/27°" index:0];
    [self addItemWithTitle:@"星期一" weather:@"雷阵雨" wind:@"微风" T:@" 39°/17°" index:1];
    [self addItemWithTitle:@"星期二" weather:@"小雨" wind:@"微风" T:@" -2°/15°" index:2];
    
}

- (void)addItemWithTitle:(NSString *)title weather:(NSString *)weather wind:(NSString *)wind T:(NSString *)T index:(int)index
{
    SXWeatherItemView *itemView = [SXWeatherItemView view];
    itemView.width = W/3;
    itemView.y = 0;
    itemView.height = 200;
    itemView.x = index * itemView.width;
    
    itemView.weather = weather;
    itemView.titleLbl.text = title;
    itemView.tLbl.text = T;
    itemView.windLbl.text = wind;
    [self.bottomView addSubview:itemView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
