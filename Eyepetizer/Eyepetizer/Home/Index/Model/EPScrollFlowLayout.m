//
//  EPScrollFlowLayout.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/30.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPScrollFlowLayout.h"

@implementation EPScrollFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.minimumInteritemSpacing = 0.f;
    self.minimumLineSpacing = 7.f;
}

@end
