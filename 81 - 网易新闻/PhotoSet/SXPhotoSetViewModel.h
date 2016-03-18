//
//  SXPhotoSetViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXPhotosDetailEntity.h"
#import "SXPhotoSetEntity.h"
#import "SXReplyEntity.h"
#import "SXNewsEntity.h"

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
 *  热门评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyModels;
/**
 *  普通评论列表
 */
@property(nonatomic,strong) NSMutableArray *replyNormalModels;
/**
 *  获取图集页数组命令
 */
@property(nonatomic, strong) RACCommand *fetchPhotoSetCommand;
/**
 *  获取图集页热门评论的命令
 */
@property(nonatomic, strong) RACCommand *fetchPhotoFeedbackCommand;
/**
 *  获取图集普通评论命令
 */
@property(nonatomic, strong) RACCommand *fetchPhotoFeedback2Command;
/**
 *  图集模型
 */
@property(nonatomic,strong) SXPhotoSetEntity *photoSet;
@end
