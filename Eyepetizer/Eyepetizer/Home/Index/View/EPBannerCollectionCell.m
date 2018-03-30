//
//  EPBannerCollectionCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/27.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPBannerCollectionCell.h"
#import "EPEmbeddedCellAgent.h"
#import "EPBannerCell.h"
#import "EPScrollFlowLayout.h"

@interface EPBannerCollectionCell ()

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) EPEmbeddedCellAgent *agent;

@end

@implementation EPBannerCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
        [self initUI];
    }
    return self;
}

- (void)defaultConfig {
    self.agent = [[EPEmbeddedCellAgent alloc] init];
    self.agent.customer = self.collectionView;
}

- (void)initUI {
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomLine];
    [self addConstraint];
}

- (void)addConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (ScreenWidth - 30) * 0.58));
//        make.width.equalTo(@(ScreenWidth));
        make.top.equalTo(self);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.collectionView);
        make.height.equalTo(@(1 / [UIScreen mainScreen].scale));
    }];
}


- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.agent.dataSource = model.data.itemList;
}


#pragma mark - lazy load
#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        EPScrollFlowLayout *layout = [EPScrollFlowLayout new];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self.agent;
        _collectionView.delegate = self.agent;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[EPBannerCell class] forCellWithReuseIdentifier:EPCellTypeBanner];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EPCellUnknowType];
    }
    return _collectionView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = PlaceHolderColor;
    }
    return _bottomLine;
}

@end
