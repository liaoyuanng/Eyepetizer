//
//  EPHomeCollectionController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/21.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeCollectionController.h"
#import "EPScrollCell.h"
#import "EPHomeCollectionViewModel.h"

static NSString * const cellID = @"com.imliaoyuan.home";

@interface EPHomeCollectionController ()

@end

@implementation EPHomeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:[EPScrollCell class] forCellWithReuseIdentifier:cellID];
    
    if (self.apiUrl) {
        EPHomeCollectionViewModel *viewModel = [[EPHomeCollectionViewModel alloc] init];
        [[viewModel.requestCommand execute:self.apiUrl] subscribeNext:^(id  _Nullable x) {
            NSArray *models = x[@"itemList"];
            [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                EPHomeCollectionViewModel *model = [EPHomeCollectionViewModel yy_modelWithDictionary:obj];
                NSLog(@"%@",model);
            }];
        }];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, 360);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //    cell.titleLabel.text = @"近期热门";
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
