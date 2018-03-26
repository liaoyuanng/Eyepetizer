//
//  EPBannerCell.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/26.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPBannerCell.h"

@interface EPBannerCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation EPBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
    }];
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    
}

#pragma mark - lazy load
#pragma mark -

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}


@end
