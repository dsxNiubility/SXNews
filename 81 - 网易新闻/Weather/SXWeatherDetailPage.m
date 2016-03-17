//
//  SXWeatherDetailPage.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherDetailPage.h"
#import "SXWeatherItemView.h"
#import "SXWeatherEntity.h"

#define W [UIScreen mainScreen].bounds.size.width

@interface SXWeatherDetailPage ()
@property(nonatomic,strong)UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *dateWeekLbl;
@property (weak, nonatomic) IBOutlet UILabel *airPMLbl;
@property (weak, nonatomic) IBOutlet UILabel *climateLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;

@end

@implementation SXWeatherDetailPage

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

    [self addWeather];
    for (int i = 1 ; i < 4 ; i++) {
        SXWeatherDetailEntity *weatherDetail = self.weatherModel.detailArray[i];
        [self addItemWithTitle:weatherDetail.week weather:weatherDetail.climate wind:weatherDetail.wind T:weatherDetail.temperature index:i-1];
    }
    
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
    
    NSMutableString *temp = [T mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    itemView.tLbl.text = temp;
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

- (void)addWeather
{
    
    SXWeatherDetailEntity *weatherDetail = self.weatherModel.detailArray[0];
    
    NSMutableString *temp = [weatherDetail.temperature mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    self.tempLbl.text = temp;
    
    self.dateWeekLbl.text = [NSString stringWithFormat:@"%@  %@",self.weatherModel.dt,weatherDetail.week];
    
    NSString *desc;
    int pm = self.weatherModel.pm2d5.pm2_5.intValue;
    if (pm < 50) {
        desc = @"优";
    }else if (pm < 100){
        desc = @"良";
    }else{
        desc = @"差";
    }
    
    self.airPMLbl.text = [NSString stringWithFormat:@"PM2.5 %d %@",pm,desc];
    //    self.localLbl.text = @"北京";
    self.climateLbl.text = weatherDetail.climate;
    self.windLbl.text = weatherDetail.wind;
    
    if ([weatherDetail.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([weatherDetail.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([weatherDetail.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([weatherDetail.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([weatherDetail.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([weatherDetail.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:self.weatherModel.pm2d5.nbg2] placeholderImage:[UIImage imageNamed:@"QingTian"]];
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
