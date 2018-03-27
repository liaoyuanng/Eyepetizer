//
//  EPScrollCellAgent.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/20.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class EPHomeCollectionViewModel;

@interface EPEmbeddedCellAgent : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *customer;

@property (nonatomic, copy) NSArray<EPHomeCollectionViewModel *> *dataSource;

@end
