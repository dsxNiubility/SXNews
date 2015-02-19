//
//  SXReplyModel.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/9.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXReplyModel : NSObject

/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;

@end
