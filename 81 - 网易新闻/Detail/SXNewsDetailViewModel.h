//
//  SXNewsDetailViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXNewsDetailEntity.h"
#import "SXSimilarNewsEntity.h"
#import "SXReplyEntity.h"
#import "SXNewsEntity.h"

@interface SXNewsDetailViewModel : NSObject

@property(nonatomic,strong) SXNewsDetailEntity *detailModel;
@property(nonatomic,strong) SXNewsEntity *newsModel;
/**
 *  相似新闻
 */
@property(nonatomic,strong)NSArray *sameNews;
/**
 *  搜索关键字
 */
@property(nonatomic,strong)NSArray *keywordSearch;
/**
 *  评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyModels;
/**
 *  按钮标题
 */
@property(nonatomic,strong)NSString *replyCountBtnTitle;
/**
 *  获取搜索结果数组命令
 */
@property(nonatomic, strong) RACCommand *fetchNewsDetailCommand;
/**
 *  获取热门评价数组命令
 */
@property(nonatomic, strong) RACCommand *fetchHotFeedbackCommand;
/**
 *  将拼接html的操作在业务逻辑层做
 *
 *  @return 将拼好后的html字符串返回
 */
- (NSString *)getHtmlString;

@end
