//
//  EPVideoBriefCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/30.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPVideoBriefCell.h"
#import "EPEmbeddedCellAgent.h"
#import "EPScrollFlowLayout.h"
#import "EPFollowCardCell.h"

@interface EPVideoBriefCell ()

@property (nonatomic, strong) UIButton *follow;

@property (nonatomic, strong) UIImageView *avatorImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) EPEmbeddedCellAgent *agent; 

@end

@implementation EPVideoBriefCell

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
    [self addConstraint];
}

- (void)addConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (ScreenWidth - 30) * 0.58));
        //        make.width.equalTo(@(ScreenWidth));
        make.top.equalTo(self);
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
        [_collectionView registerClass:[EPFollowCardCell class] forCellWithReuseIdentifier:EPCellTypeBanner];
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EPCellUnknowType];
    }
    return _collectionView;
}

- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc] init];
        _avatorImageView.layer.cornerRadius = 30;
        _avatorImageView.layer.masksToBounds = YES;
    }
    return _avatorImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory label];
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.font = FZFontSize(18);
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _titleLabel = [EPFactory label];
        _titleLabel.textColor = RGB(136, 136, 136);
        _titleLabel.font = FZFontSize(14);
    }
    return _descLabel;
}

- (UIButton *)follow {
    if (!_follow) {
        _follow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_follow setTitle:@"+ 关注" forState:UIControlStateNormal];
        _follow.titleLabel.font = FZFontSize(17);
        self.followAction = [_follow rac_signalForControlEvents:UIControlEventTouchUpInside];
        _follow.layer.cornerRadius = 4.f;
        _follow.layer.masksToBounds = YES;
    }
    return _follow;
}

@end
