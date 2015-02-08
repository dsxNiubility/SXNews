//
//  SXPhotoSetController.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNewsModel.h"

@interface SXPhotoSetController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhotos;

@property(nonatomic,strong) SXNewsModel *newsModel;
@end
