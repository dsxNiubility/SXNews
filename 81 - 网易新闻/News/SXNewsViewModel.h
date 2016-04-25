//
//  SXNewsViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXNewsViewModel : NSObject

/**
 *  获取新闻概要模型
 */
@property(nonatomic,strong)RACCommand *fetchNewsEntityCommand;

@end
