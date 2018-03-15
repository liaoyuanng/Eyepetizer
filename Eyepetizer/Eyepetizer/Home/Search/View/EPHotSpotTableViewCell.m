//
//  EPHotSpotTableViewCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/15.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHotSpotTableViewCell.h"

@interface EPHotSpotTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation EPHotSpotTableViewCell

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
    [self addSubview:self.label];
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = RGB(70, 135, 215);
        _label.font = FZFontSize(13);
        _label.frame = CGRectMake(15, 0, ScreenWidth - 30, 40);
    }
    return _label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
