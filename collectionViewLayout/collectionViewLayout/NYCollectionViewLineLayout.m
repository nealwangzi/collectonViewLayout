//
//  NYCollectionViewLineLayout.m
//  0828-自定义流水布局
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYCollectionViewLineLayout.h"

static CGFloat const itemWH = 100;
@implementation NYCollectionViewLineLayout
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //计算可见矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    /**
     *  1.取得默认的cell的uicollectionViewLayoutatttrs
     */
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕中间的x
    CGFloat centerx = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //遍历所有的属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //不可见的cell，忽略掉
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) {
            continue;
        }
        CGFloat itemCenterx = attrs.center.x;
        //差距越大，缩放比例越小
        CGFloat scale =(1-ABS(centerx - itemCenterx)/(self.collectionView.frame.size.width * 0.5));
        attrs.transform = CGAffineTransformMakeScale(scale, scale);

    }
    return array;
    
}
//重新画布局，显示的边界改变：内部重新调用layoutAttributesForElementsInRect获得所有cell的布局属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
//用来设置scorllView停止滚动时的位置； 原本scrollview停止滚动的那一个位置 ； 滚动速度
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出scrollview最后停留的范围
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
    
    //取出数组
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    CGFloat adjustoffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x- centerX)<ABS(adjustoffsetX) ) {
            adjustoffsetX = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustoffsetX, proposedContentOffset.y);
}
//一些初始化工作在此方法实现，collection已经初始化完毕
- (void)prepareLayout
{
    [super prepareLayout];
    //设置cell的尺寸
    self.itemSize = CGSizeMake(itemWH, itemWH);
    /**
     *  设置水平滚动
     */
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每个cell 都有自己的UICollectionViewLayoutAttributes
    //UICollectionViewLayoutAttributes
    self.minimumLineSpacing = 10;
    CGFloat inset = (self.collectionView.frame.size.width - itemWH)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);

    
}

@end
