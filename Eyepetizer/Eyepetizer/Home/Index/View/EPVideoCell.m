//
//  EPVideoCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/27.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPVideoCell.h"

@interface EPVideoCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *tagsLabel;

@end

@implementation EPVideoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.coverImageView];
    [self addSubview:self.shareBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.tagsLabel];
    
    [self addConstraint];
}

- (void)addConstraint {
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(self.coverImageView.mas_height).multipliedBy(1.78);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(12);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.coverImageView).offset(10);
    }];
    
    [self.tagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.shareBtn.mas_left);
        make.bottom.equalTo(self.coverImageView.mas_bottom).offset(-15);
        make.height.equalTo(@20);
    }];
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.coverImageView.yy_imageURL = URL(model.data.cover.feed);
    self.titleLabel.text = model.data.title;
    self.tagsLabel.text = [NSString stringWithFormat:@"#%@",model.data.category];
}

#pragma mark - lazy load
#pragma mark -

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.layer.cornerRadius = 4.f;
        _coverImageView.layer.masksToBounds = true;
        _coverImageView.backgroundColor = PlaceHolderColor;
    }
    return _coverImageView;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _shareBtn.alpha = 0.6;
        [_shareBtn setImage:ImageNamed(@"action_share_grey") forState:UIControlStateNormal];
        self.share = [_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory labelWithText:nil textColor:RGB(68, 68, 68) font:FZFontSize(13) lineBreakMode:NSLineBreakByTruncatingTail];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)tagsLabel {
    if (!_tagsLabel) {
        _tagsLabel = [EPFactory labelWithText:nil textColor:RGB(136, 136, 136) font:FZXFontSize(12) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _tagsLabel;
}

@end
