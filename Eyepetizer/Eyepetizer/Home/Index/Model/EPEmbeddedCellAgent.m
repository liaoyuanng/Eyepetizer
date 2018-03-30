//
//  EPScrollCellAgent.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/20.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPEmbeddedCellAgent.h"
#import "EPFollowCardCell.h"
#import "EPHomeCollectionViewModel.h"

@interface EPEmbeddedCellAgent ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation EPEmbeddedCellAgent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.index = 0;
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.customer reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

//    if (![[EPConfigurationManager manager] verificationCellType:self.dataSource[indexPath.row].type]) {
//        UICollectionViewCell *unknow = [collectionView dequeueReusableCellWithReuseIdentifier:EPCellUnknowType forIndexPath:indexPath];
//        return unknow;
//    }
    UICollectionViewCell<EPHomeCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.dataSource[indexPath.row].type forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setLineHidden:)]) {
        [cell setLineHidden:YES];
    }
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[EPConfigurationManager manager] cellSizeByType:self.dataSource[indexPath.row].type];
}

// 设置每次滚动的偏移量。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (velocity.x == 0) {
        if ((scrollView.contentOffset.x - (ScreenWidth * 0.928 + 7) * self.index) > 10) {
            self.index = MIN(self.index + 1, self.dataSource.count - 1);
        } else {
            self.index = MAX(self.index - 1, 0);
        }
    } else {
        if (velocity.x > 0) {
            self.index = MIN(self.index + 1, self.dataSource.count - 1);
        } else {
            self.index = MAX(self.index - 1, 0);
        }
    }
    
    CGPoint newPosition = CGPointMake(self.index * (ScreenWidth * 0.928 + 7), targetContentOffset->y);
    *targetContentOffset = newPosition;
}

@end
