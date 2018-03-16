//
//  EPSearchBar.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/15.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPSearchBar.h"
@interface EPSearchBar ()

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong, readwrite) RACSignal *cancel;

@end

@implementation EPSearchBar

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.textField];
    
    [self addConstraint];
}

- (void)addConstraint {
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(47, 44));
        make.centerY.equalTo(self);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.cancelBtn.mas_left);
        make.height.equalTo(@34 );
        make.centerY.equalTo(self);
    }];
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

#pragma mark - lazy load
#pragma mark -

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = FZXFontSize(14);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(47, 47, 47) forState:UIControlStateNormal];
        // Emmmm,I'm a liar...
        [_cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4 * [UIScreen mainScreen].scale / 2, 0, 0)];
        self.cancel = [_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.placeholder = @"搜索视频、作者、用户及标签";
        _textField.font = FZXFontSize(14);
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = RGB(237, 237, 237);
        _textField.layer.cornerRadius = 4.f;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        // search icon
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search_grey")];
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.frame = CGRectMake(0, 0, 30, 30);
        _textField.leftView = searchIcon;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        // 立即进入编辑状态。
        [_textField becomeFirstResponder];
    }
    return _textField;
}

@end
