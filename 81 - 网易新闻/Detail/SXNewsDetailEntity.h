//
//  SXNewsDetailEntity.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXNewsDetailEntity : NSObject

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图(希望这个数组中以后放HMNewsDetailImg模型) */
@property (nonatomic, strong) NSArray *img;
/** 模块名*/
@property(nonatomic,copy)NSString *replyBoard;
/** 回复数*/
@property(nonatomic,assign)NSInteger replyCount;

+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
