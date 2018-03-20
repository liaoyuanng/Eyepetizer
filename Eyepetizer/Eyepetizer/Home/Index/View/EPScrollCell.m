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

@property (nonatomic, strong) UIButton *titleLabel;

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
    self.agent.customer = self;
}

- (void)initUI {
    [self addSubview:self.dateLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomLine];
    [self addConstraint];
}

- (void)addConstraint {
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.dateLabel);
        make.top.equalTo(self.dateLabel.mas_bottom);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (ScreenWidth - 30) * 0.58 + 70));
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1 / [UIScreen mainScreen].scale));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // re layout buttom's image and titleLabel. label on left and image on right.
    self.titleLabel.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.titleLabel.frame.size.width, 0, 0);
    self.titleLabel.titleEdgeInsets = UIEdgeInsetsMake(0, -self.titleLabel.imageView.frame.size.width, 0, 0);
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
        _dateLabel = [EPFactory labelWithText:nil textColor:RGB(136, 136, 136) font:[UIFont fontWithName:@"DINCondensedBold" size:12.f]];
        _dateLabel.text = @"FRI789, MARCH 16";
    }
    return _dateLabel;
}

- (UIButton *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleLabel setTitle:@"开眼今日编辑精选" forState:UIControlStateNormal];
        [_titleLabel setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _titleLabel.titleLabel.font = FZFontSize(30);
        _titleLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_titleLabel setImage:ImageNamed(@"action_more_black") forState:UIControlStateNormal];
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = RGB(237, 237, 237);
    }
    return _bottomLine;
}

@end
