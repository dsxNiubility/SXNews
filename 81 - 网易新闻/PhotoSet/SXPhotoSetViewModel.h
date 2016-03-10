//
//  SXPhotoSetViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXNewsEntity.h"
#import "SXPhotoSetEntity.h"
#import "SXReplyEntity.h"

@interface SXPhotoSetViewModel : NSObject

/**
 *  新闻模型
 */
@property(nonatomic,strong) SXNewsEntity *newsModel;
/**
 *  按钮标题
 */
@property(nonatomic,strong)NSString *replyCountBtnTitle;
/**
 *  评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyModels;
/**
 *  获取图集页数组命令
 */
@property(nonatomic, strong) RACCommand *fetchPhotoSetCommand;
/**
 *  获取图集评论命令
 */
@property(nonatomic, strong) RACCommand *fetchPhotoFeedbackCommand;
/**
 *  图集模型
 */
@property(nonatomic,strong) SXPhotoSetEntity *photoSet;
@end
