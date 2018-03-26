//
//  EPNormalCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPNormalCell.h"

@interface EPNormalCell ()

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIImageView *avatorImageView;

@property (nonatomic, strong) UIImageView *badgeImageView;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong, readwrite) RACSignal *share;

@end

@implementation EPNormalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.shareBtn];
    [self addSubview:self.timeLabel];
    [self addSubview:self.badgeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.coverImageView];
    [self addSubview:self.badgeImageView];
    [self addSubview:self.avatorImageView];
    [self addSubview:self.bottomLine];
    [self addConstraint];
}

- (void)addConstraint {

    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
        make.height.equalTo(self.coverImageView.mas_width).multipliedBy(0.58);
    }];
    
    [self.avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self.avatorImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatorImageView.mas_right).offset(8);
        make.right.equalTo(self.shareBtn.mas_left).offset(-8);
        make.top.equalTo(self.avatorImageView);
        make.height.equalTo(self.avatorImageView).multipliedBy(0.5);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.titleLabel);
        make.bottom.equalTo(self.avatorImageView);
    }];
    
    [self.badgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView).offset(10);
        make.top.equalTo(self.coverImageView).offset(10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.coverImageView);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1.0 / [UIScreen mainScreen].scale));
    }];
}

#pragma mark - public
#pragma mark -

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.titleLabel.text = model.data.header.title;
    self.descriptionLabel.text = model.data.header.desc;
    self.avatorImageView.yy_imageURL = URL(model.data.header.icon);
    self.coverImageView.yy_imageURL = URL(model.data.content.data.cover.feed);
}

- (void)setHideLine:(BOOL)hideLine {
    _hideLine = hideLine;
    self.bottomLine.hidden = hideLine;
}

#pragma mark - lazy load
#pragma mark -

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.alpha = 0.6;
        [_shareBtn setImage:ImageNamed(@"nav_share") forState:UIControlStateNormal];
        self.share = [_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [EPFactory labelWithText:nil textColor:UIColor.whiteColor font:FZFontSize(10)];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory labelWithText:nil textColor:RGB(68, 68, 68) font:FZFontSize(13) lineBreakMode:NSLineBreakByTruncatingTail];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        
    }
    return _badgeLabel; //0.790625  0.7439    0.58
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [EPFactory labelWithText:nil textColor:RGB(136, 136, 136) font:FZXFontSize(12) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _descriptionLabel;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.layer.cornerRadius = 4.f;
        _coverImageView.layer.masksToBounds = true;
        _coverImageView.backgroundColor = RGB(237, 237, 237);
    }
    return _coverImageView;
}

- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [UIImageView new];
        _avatorImageView.layer.cornerRadius = 20.f;
        _avatorImageView.layer.masksToBounds = true;
        _avatorImageView.backgroundColor = RGB(237, 237, 237);
    }
    return _avatorImageView;
}

- (UIImageView *)badgeImageView {
    if (!_badgeImageView) {
        _badgeImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_badge_daily")];
    }
    return _badgeImageView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = RGB(237, 237, 237);
    }
    return _bottomLine;
}

@end
