//
//  SXNewsCollectionController.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXNewsCollectionController.h"
#import "SXCollectionCell.h"

@interface SXNewsCollectionController ()
/**
 *  流水布局
 */
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

/**
 *  存放url的数组
 */
@property(nonatomic,strong) NSArray *arrayLists;

@end

@implementation SXNewsCollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.collectionView.contentOffset = CGPointMake(0, 100);
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentStop) name:@"contentStop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentStart) name:@"contentStart" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(theTopVc) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}

//- (void)theTopVc
//{
//    NSLog(@"bbbbb");
//}

- (void)contentStop
{
    self.collectionView.scrollEnabled = NO;
}
- (void)contentStart
{
    self.collectionView.scrollEnabled = YES;
}

#pragma mark - /*************************懒加载 ***************************/
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

#pragma mark - /*********************** 在即将显示里添加 大小更准 ***************************/
- (void)viewWillAppear:(BOOL)animated
{
    // 设置行间距列间距 大小 方向
    self.layout.minimumInteritemSpacing = 0.0;
    self.layout.minimumLineSpacing = 0.0;
    self.layout.itemSize = self.view.bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置分页和滚动条
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    self.collectionView.showsVerticalScrollIndicator = YES;
    
//    self.collectionView.contentOffset = CGPointMake(0, 20);
    
}


#pragma mark - /************************* collect的数据源方法 ***************************/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayLists.count;
}

//static float a = 0.2;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    [self addChildViewController:cell.nav];
    cell.urlString = self.arrayLists[indexPath.item][@"urlString"];
    
    return cell;
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end