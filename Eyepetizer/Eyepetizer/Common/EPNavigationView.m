//
//  EPNavigationView.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/30.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPNavigationView.h"

@interface EPNavigationView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *search;

@property (nonatomic, strong) UIButton *leftItem;

@property (nonatomic, strong) UIButton *rightItem;

@end

@implementation EPNavigationView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - lazy load
#pragma mark -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory label];
        _titleLabel.font = [UIFont fontWithName:@"Lobster" size:20];
        _titleLabel.textColor = RGB(0, 0, 0);
    }
    return _titleLabel;
}

- (UIButton *)search {
    if (!_search) {
        
    }
    return _search;
}

- (UIButton *)leftItem {
    if (!_leftItem) {
        
    }
    return _leftItem;
}

-(UIButton *)rightItem {
    if (!_rightItem) {
        
    }
    return _rightItem;
}
@end
