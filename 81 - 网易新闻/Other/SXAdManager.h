//
//  SXAdManager.h
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/9/27.
//  Copyright © 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SXAdManager : NSObject

+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLatestAdImage;

@end
