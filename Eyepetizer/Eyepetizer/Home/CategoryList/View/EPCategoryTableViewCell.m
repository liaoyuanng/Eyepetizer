//
//  EPCategoryTableViewCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/14.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPCategoryTableViewCell.h"
#import "EPCategoryListModel.h"

@interface EPCategoryTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *dragImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation EPCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.icon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.dragImageView];
    [self addSubview:self.descriptionLabel];
    
    [self addConstraint];
}

- (void)addConstraint {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [self.dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(12);
        make.bottom.equalTo(self.icon.mas_centerY).offset(-3);
        make.right.equalTo(self.dragImageView).offset(-15);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.dragImageView.mas_left).offset(15);
        make.top.equalTo(self.icon.mas_centerY).offset(3);
    }];
}

#pragma mark - public
#pragma mark -

- (void)bindModel:(EPCategoryListModel *)model {
    self.titleLabel.text = model.data.title;
    self.descriptionLabel.text = model.data.desc;
    self.icon.yy_imageURL = [NSURL URLWithString:model.data.icon];
}

#pragma mark - lazy load
#pragma mark -

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.layer.cornerRadius = 2.f;
        _icon.layer.masksToBounds = true;
    }
    return _icon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = FZFontSize(13);
        _titleLabel.text = @"#创意";
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = FontSize(13);
        _descriptionLabel.textColor = RGB(120, 120, 120);
        _descriptionLabel.numberOfLines = 1;
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descriptionLabel.text = @"12345";
    }
    return _descriptionLabel;
}

- (UIImageView *)dragImageView {
    if (!_dragImageView) {
        _dragImageView = [UIImageView new];
        _dragImageView.image = ImageNamed(@"ic_selected_setting_small_gray");
    }
    return _dragImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
