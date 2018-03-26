//
//  EPScrollCellAgent.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/20.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPScrollCellAgent.h"
#import "EPNormalCell.h"

@interface EPScrollCellAgent ()

@end

@implementation EPScrollCellAgent

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.customer reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.hideLine = YES;
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}


@end
