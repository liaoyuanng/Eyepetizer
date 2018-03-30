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
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
    }];
}

- (void)bindModel:(EPHomeCollectionViewModel *)model {
    self.imageView.yy_imageURL = URL(model.data.image);
}

#pragma mark - lazy load
#pragma mark -

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 4.f;
        _imageView.layer.masksToBounds = true;
        _imageView.backgroundColor = PlaceHolderColor;
    }
    return _imageView;
}


@end
