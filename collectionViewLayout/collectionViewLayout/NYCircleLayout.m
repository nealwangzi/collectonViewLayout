//
//  NYCircleLayout.m
//  0828-自定义流水布局
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYCircleLayout.h"

@implementation NYCircleLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        [array addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(50, 50);
    
    CGFloat radius = 70;
    CGPoint center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height*0.5);
    
    CGFloat angledelta = M_PI * 2 /[self.collectionView numberOfItemsInSection:indexPath.section];
    
    CGFloat angle = indexPath.item * angledelta;
    
    attrs.center = CGPointMake(center.x+radius * cos(angle), center.y - radius*sin(angle));
    attrs.zIndex = indexPath.item;
    
    return attrs;
}
@end
