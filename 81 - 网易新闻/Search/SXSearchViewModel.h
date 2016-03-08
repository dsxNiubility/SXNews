//
//  SXSearchViewModel.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXSearchViewModel : NSObject

@property(nonatomic,strong)NSString *searchText;

/**
 *  获取当天热词命令
 */
@property(nonatomic, strong) RACCommand *fetchHotWordCommand;

/**
 *  获取搜索结果数组命令
 */
@property(nonatomic, strong) RACCommand *fetchSearchResultListArray;

@end
