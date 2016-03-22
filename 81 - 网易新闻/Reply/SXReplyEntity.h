//
//  SXReplyEntity.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/9.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXReplyEntity : NSObject

/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;
/** 头像*/
@property(nonatomic,strong)NSString *icon;
/** 回复时间*/
@property(nonatomic,copy)NSString *rtime;


/*************下面是hotreply 直接写在一起了************/
/** 用户头像*/
@property(nonatomic,copy)NSString *timg;
/** 用户地址*/
@property(nonatomic,copy)NSString *f;
/** 实际评价*/
@property(nonatomic,copy)NSString *b;
/** 用户名称*/
@property(nonatomic,copy)NSString *n;
/** 顶帖人数*/
@property(nonatomic,copy)NSString *v;

@end
