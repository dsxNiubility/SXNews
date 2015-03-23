//
//  ViewController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "ViewController.h"
#import "SXNetworkTools.h"
#import "SXNewsModel.h"

@interface ViewController ()

@property(nonatomic,strong) NSArray *arrayList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - /************************* 在这里做完实验就不用了 ***************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // url  http://c.m.163.com/nc/article/headline/T1348647853363/full.html
    // http://c.m.163.com/nc/article/headline/T1348647853363/0-30.html
    
    // netconnect
    [[[SXNetworkTools sharedNetworkTools]GET:@"nc/article/headline/T1348647853363/0-20.html" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        
        // 取出第一个数组，扩展性好的
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        // 取出小的一组 遍历打印出声明
        [self writeInfoWithDict:temArray[1]];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:temArray.count];
        [temArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"=====》%tu",idx);
            SXNewsModel *news = [SXNewsModel newsModelWithDict:obj];
            [arrayM addObject:news];
        }];
        self.arrayList = arrayM;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
    
}

#pragma mark - ******************** 通过此方法打印出成员变量
- (void)writeInfoWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@,%@",key,[obj class]);
        
        NSString *className = NSStringFromClass([obj class]) ;
        
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] ) {
            [strM appendFormat:@"@property (nonatomic,copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"]){
            [strM appendFormat:@"@property (nonatomic,strong)NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic,copy)NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic,assign)BOOL %@;\n",key];
        }
        
        NSLog(@"\n%@",strM);
    }];
    
}

@end
