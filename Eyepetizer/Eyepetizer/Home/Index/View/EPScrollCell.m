//
//  EPScrollCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPScrollCell.h"
#import "EPNormalCell.h"

@interface EPScrollCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIButton *titleLabel;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign, getter=isAdjust) BOOL adjust;

@end

@implementation EPScrollCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.adjust = NO;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.dateLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    
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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isAdjust) {
        self.titleLabel.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.titleLabel.frame.size.width, 0, 0);
        self.titleLabel.titleEdgeInsets = UIEdgeInsetsMake(0, -self.titleLabel.imageView.frame.size.width, 0, 0);
        self.adjust = YES;
    }
}


#pragma mark - lazy load
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        
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

@end
