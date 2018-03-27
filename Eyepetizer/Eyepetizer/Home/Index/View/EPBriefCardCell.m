//
//  EPBriefCardCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/27.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPBriefCardCell.h"

@interface EPBriefCardCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation EPBriefCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.coverImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.arrowImageView];
    
    [self addConstraint];
}

- (void)addConstraint {
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(47, 47));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(12);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@(20));
        make.bottom.equalTo(self.coverImageView.mas_centerY);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.coverImageView.yy_imageURL = URL(model.data.icon);
    self.titleLabel.text = model.data.title;
    self.descLabel.text = model.data.desc;
}

#pragma mark - lazy load
#pragma mark -

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.backgroundColor = PlaceHolderColor;
        _coverImageView.layer.cornerRadius = 4.f;
        _coverImageView.layer.masksToBounds = YES;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory labelWithText:nil textColor:RGB(68, 68, 68) font:FZFontSize(13) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [EPFactory labelWithText:nil textColor:RGB(136, 136, 136) font:FZXFontSize(12) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _descLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = PlaceHolderColor;
    }
    return _bottomLine;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"action_more_black")];
    }
    return _arrowImageView;
}

@end
