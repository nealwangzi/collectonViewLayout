//
//  NYCollectionViewCell.m
//  0828-自定义流水布局
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYCollectionViewCell.h"

@interface NYCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end
@implementation NYCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.pictureView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pictureView.layer.borderWidth = 3;
    self.pictureView.layer.cornerRadius = 3;
    self.pictureView.layer.masksToBounds = YES;
}

- (void)setImagename:(NSString *)imagename
{
    _imagename = imagename;
    self.pictureView.image = [UIImage imageNamed:imagename];
}
@end
