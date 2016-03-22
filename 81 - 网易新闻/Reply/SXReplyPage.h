//
//  SXReplyPage.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXReplyViewModel.h"

@interface SXReplyPage : UIViewController

@property(nonatomic,strong) SXNewsEntity *newsModel;
@property(nonatomic,assign)SXReplyPageFrom source;
@property(nonatomic,copy)NSString *photoSetId;

@end
