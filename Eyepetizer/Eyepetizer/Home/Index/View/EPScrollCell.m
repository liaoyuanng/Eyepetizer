//
//  EPScrollCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPScrollCell.h"
#import "EPNormalCell.h"
#import "EPScrollCellAgent.h"

@interface EPScrollCell ()

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIButton *title;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign, getter=isAdjust) BOOL adjust;

@property (nonatomic, strong) EPScrollCellAgent *agent;

@end

@implementation EPScrollCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
        [self initUI];
    }
    return self;
}

- (void)defaultConfig {
    self.agent = [[EPScrollCellAgent alloc] init];
    self.agent.customer = self.collectionView;
}

- (void)initUI {
    [self addSubview:self.dateLabel];
    [self addSubview:self.title];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomLine];
    [self addConstraint];
}

- (void)addConstraint {
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(35);
        make.height.equalTo(@15);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.dateLabel);
        make.top.equalTo(self.dateLabel.mas_bottom);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (ScreenWidth - 30) * 0.58 + 70 + 15));
        make.top.equalTo(self.title.mas_bottom);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.collectionView.mas_bottom).offset(8);
        make.height.equalTo(@(1 / [UIScreen mainScreen].scale));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // re layout buttom's image and title. label on left and image on right.
    self.title.imageEdgeInsets = UIEdgeInsetsMake(0, self.title.titleLabel.frame.size.width, 0, 0);
    self.title.titleEdgeInsets = UIEdgeInsetsMake(0, -self.title.imageView.frame.size.width, 0, 0);
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.dateLabel.text = model.data.header.subTitle;
    self.title.titleLabel.font = [[EPConfigurationManager manager] fontWithKey:model.data.header.font size:27.f];
    [self.title setTitle:model.data.header.title forState:UIControlStateNormal];
    self.agent.dataSource = model.data.itemList;
}

#pragma mark - lazy load
#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self.agent;
        _collectionView.delegate = self.agent;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[EPNormalCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [EPFactory labelWithText:nil textColor:RGB(136, 136, 136) font:[UIFont fontWithName:@"DIN Condensed" size:15.f]];
    }
    return _dateLabel;
}

- (UIButton *)title {
    if (!_title) {
        _title = [UIButton buttonWithType:UIButtonTypeCustom];
        [_title setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _title.titleLabel.font = FZFontSize(30);
        _title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_title setImage:ImageNamed(@"action_more_black") forState:UIControlStateNormal];
    }
    return _title;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = PlaceHolderColor;
    }
    return _bottomLine;
}

@end
