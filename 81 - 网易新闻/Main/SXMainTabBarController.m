//
//  SXMainTabBarController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/4/9.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXMainTabBarController.h"
#import "SXBarButton.h"
#import "SXTabBar.h"

#import "SXMainViewController.h"
#import "SXNavController.h"


@interface SXMainTabBarController ()<SXTabBarDelegate>

@end

@implementation SXMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SXTabBar *tabBar = [[SXTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    
    [self.tabBar addSubview:tabBar];
    
//    [self.tabBar setShadowImage:[UIImage imageNamed:@"shawdo"]];
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"shawdo"];
    tabBar.delegate = self;
    
    
    [tabBar addImageView];
    
    [tabBar addBarButtonWithNorName:@"tabbar_icon_news_normal" andDisName:@"tabbar_icon_news_highlight" andTitle:@"新闻"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_reader_normal" andDisName:@"tabbar_icon_reader_highlight" andTitle:@"阅读"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_media_normal" andDisName:@"tabbar_icon_media_highlight" andTitle:@"视听"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_found_normal" andDisName:@"tabbar_icon_found_highlight" andTitle:@"发现"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_me_normal" andDisName:@"tabbar_icon_me_highlight" andTitle:@"我"];
    
    self.selectedIndex = 1;
}

#pragma mark - ******************** SXTabBarDelegate代理方法
- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
