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

@end

@implementation SXWeatherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    bottomView.height = 250;
    bottomView.width = W;
    bottomView.x = 0;
    bottomView.y = [UIScreen mainScreen].bounds.size.height - bottomView.height;
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.2;
    
    
}

- (void)addItemWithTitle:(NSString *)title weather:(NSString *)weather wind:(NSString *)wind T:(NSString *)T index:(int)index
{
    SXWeatherItemView *itemView = [[SXWeatherItemView alloc]init];
    itemView.width = W/3;
    itemView.y = 0;
    itemView.height = 200;
    itemView.x = index * itemView.width;
    
    itemView.weather = weather;
    itemView.titleLbl.text = title;
    itemView.tLbl.text = T;
    itemView.windLbl.text = wind;
    
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
