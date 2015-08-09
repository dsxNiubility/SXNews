//
//  SXWeatherDetailVC.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXWeatherDetailVC.h"

@interface SXWeatherDetailVC ()

@end

@implementation SXWeatherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
    // Do any additional setup after loading the view from its nib.
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
