//
//  SXDetailPage.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXNewsEntity;

@interface SXDetailPage : UIViewController

@property(nonatomic,strong) SXNewsEntity *newsModel;
@property (nonatomic,assign) NSInteger index;

@end
