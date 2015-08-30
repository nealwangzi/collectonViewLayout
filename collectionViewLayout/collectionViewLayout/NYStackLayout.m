//
//  NYStackLayout.m
//  0828-自定义流水布局
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYStackLayout.h"
#define NYRandom0_1         arc4random_uniform(100)/100.0
@implementation NYStackLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count ; i++   ) {
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attrs.size = CGSizeMake(100, 100);
        attrs.center = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
        int direction = (i%2==0)?1 : -1;
        attrs.transform = CGAffineTransformMakeRotation(NYRandom0_1 * M_PI_4*direction*0.5);
        //attrs.transform3D = CATransform3DMakeRotation(arc4random_uniform(M_PI), 1.0, 1.0, 1.0);
        [array addObject:attrs];
        if (i >=5) {

            attrs.hidden = YES;
        }else
        {
            attrs.zIndex = count - i;
        }
    }
    return array;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(400, 200);
}
//返回cell对应的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
    int direction = (indexPath.item%2==0)?1 : -1;
    if (indexPath.item >=5) {
        
        attrs.hidden = YES;
    }else
    {
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
        attrs.transform = CGAffineTransformMakeRotation(NYRandom0_1 * M_PI_4*direction*0.5);

    }

    return attrs;
    
}
@end
