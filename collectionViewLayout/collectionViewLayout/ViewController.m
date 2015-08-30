//
//  ViewController.m
//  0828-自定义流水布局
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "NYCollectionViewLineLayout.h"
#import "NYStackLayout.h"
#import "NYCircleLayout.h"
#import "NYCollectionViewCell.h"
static NSString *ID = @"cell";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/* 数据源 */
@property(nonatomic , strong) NSMutableArray *images;
/* collectionview */
@property(nonatomic , weak) UICollectionView *collectionView;

@end

@implementation ViewController
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect collectionframe = CGRectMake(0, 100, self.view.frame.size.width, 200);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:collectionframe collectionViewLayout:[[NYStackLayout alloc]init]];
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"NYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView = collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imagename = self.images[indexPath.item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //删除UI，刷新UI
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[NYStackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[NYCircleLayout alloc]init] animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:[[NYStackLayout alloc]init] animated:YES];
    }
}









@end
