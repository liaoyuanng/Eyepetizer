//
//  EPScrollCellAgent.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/20.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPEmbeddedCellAgent.h"
#import "EPNormalCell.h"
#import "EPHomeCollectionViewModel.h"

@interface EPEmbeddedCellAgent ()

@end

@implementation EPEmbeddedCellAgent

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.customer reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (![[EPConfigurationManager manager] verificationCellType:self.dataSource[indexPath.row].type]) {
        NSLog(@"%@ does not exist", self.dataSource[indexPath.row].type);
        UICollectionViewCell *unknow = [collectionView dequeueReusableCellWithReuseIdentifier:EPCellUnknowType forIndexPath:indexPath];
        return unknow;
    }
    
    UICollectionViewCell<EPHomeCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.dataSource[indexPath.row].data.dataType forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setLineHidden:)]) {
        [cell setLineHidden:YES];
    }
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.dataSource[indexPath.row].data.dataType);
    return CGSizeMake(ScreenWidth, [[EPConfigurationManager manager] cellHeightByType:self.dataSource[indexPath.row].type]);
}


@end
