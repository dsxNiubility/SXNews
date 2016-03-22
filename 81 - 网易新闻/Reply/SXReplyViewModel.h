//
//  SXReplyViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/22.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXReplyEntity.h"
#import "SXNewsEntity.h"

typedef NS_ENUM(NSUInteger, SXReplyPageFrom) {
    SXReplyPageFromNewsDetail = 0,
    SXReplyPageFromPhotoset = 1,
};

@interface SXReplyViewModel : NSObject
/**
 *  评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyModels;
/**
 *  普通评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyNormalModels;
/**
 *  获取热门回复命令
 */
@property(nonatomic, strong) RACCommand *fetchHotReplyCommand;
/**
 *  获取普通回复命令
 */
@property(nonatomic, strong) RACCommand *fetchNormalReplyCommand;
/**
 *  新闻概览模型
 */
@property(nonatomic,strong) SXNewsEntity *newsModel;
/**
 *  评价页的来源
 */
@property(nonatomic,assign)SXReplyPageFrom source;
/**
 *  如果是图集页需要传入phoSetPostID
 */
@property(nonatomic,copy)NSString *photoSetPostID;


@end
