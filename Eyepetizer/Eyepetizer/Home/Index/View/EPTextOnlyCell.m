//
//  EPTextOnlyCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPTextOnlyCell.h"

@interface EPTextOnlyCell ()

@property (nonatomic, strong) UIButton *title;

@end

@implementation EPTextOnlyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(40);
        make.bottom.equalTo(self);
    }];
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    [self.title setTitle:model.data.text forState:UIControlStateNormal];
    
    
    if ([model.data.type hasPrefix:@"header"]) {
        self.title.titleLabel.font = FZFontSize(22);

        self.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    if ([model.data.type hasPrefix:@"footer"]) {
        self.title.titleLabel.font = FZFontSize(12);

        self.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    if (!model.data.actionUrl || model.data.actionUrl.length == 0) {
        [self.title setImage:[UIImage new] forState:UIControlStateNormal];
    } else {
        [self.title setImage:ImageNamed(@"action_more_black") forState:UIControlStateNormal];
    }
    
    [self.title.titleLabel sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%f",self.title.titleLabel.frame.size.width);
    self.title.imageEdgeInsets = UIEdgeInsetsMake(0, self.title.titleLabel.frame.size.width, 0, -self.title.titleLabel.frame.size.width);
    self.title.titleEdgeInsets = UIEdgeInsetsMake(0, -self.title.imageView.frame.size.width, 0, self.title.imageView.frame.size.width);
}

- (UIButton *)title {
    if (!_title) {
        _title = [UIButton buttonWithType:UIButtonTypeCustom];
        // default setting.
        _title.titleLabel.font = FZFontSize(22);
        [_title setTitleColor:RGB(68, 68, 68) forState:UIControlStateNormal];
        _title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_title setImage:ImageNamed(@"action_more_black") forState:UIControlStateNormal];
    }
    return _title;
}
@end
