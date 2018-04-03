//
//  EPHomeNavigationView.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPNavigationView.h"

#define UN_SHOW -1000

static const NSTimeInterval animationDuration = 0.2;

@interface EPNavigationView () {
    CGFloat _btnWidth;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *menuBtn;

@property (nonatomic, strong) UIScrollView *categoryView;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, strong) UIView *effectView;

@property (nonatomic, strong, readwrite) RACSignal *menuSignal;

@property (nonatomic, strong, readwrite) RACSignal *searchSignal;

@property (nonatomic, strong, readwrite) RACSubject *categorySingal;

@property (nonatomic, strong, readwrite) RACSubject *defaultSeleted;

@property (nonatomic, strong) UIButton *lastSelectedBtn;

@property (nonatomic, strong) NSDictionary *datas;

@property (nonatomic, copy) NSArray<EPHomeCategoryListModel *> *dataSource;

@end

@implementation EPNavigationView

- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self initUI];
//    }
//    return self;
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
    self.type = EPNavigationViewTypeNormal;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self addSubview:self.effectView];
    
    [self addSubview:self.searchBtn];
    [self addSubview:self.categoryView];
    [self.categoryView addSubview:self.indicator];
}
#pragma mark - public
#pragma mark -

- (void)bindModel:(NSDictionary *)datas {
    _datas = datas;
    [self createCategoryItems];
}

- (void)updateIndex:(NSInteger)index {
    UIButton *btn = [self viewWithTag:1000 + index];
    [self updateIndicator:btn];
}

#pragma mark - private
#pragma mark -


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // set effect frame.
    self.effectView.frame = CGRectMake(0, 0, ScreenWidth, self.ep_height);
    
    if (self.type == EPNavigationViewTypeScroll) {
        // Set btn width.
        _btnWidth = 55.f;
        
        // Add menu btn. Only active in this case.
        [self addSubview:self.menuBtn];
        
        // Set search btn position.
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.menuBtn.mas_right);
            make.right.equalTo(self.searchBtn.mas_left);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    
    if (self.type == EPNavigationViewTypeNormal) {
        
        _btnWidth = ScreenWidth / 2;
        
        [self addSubview:self.titleLabel];
        // Set search btn position.
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@(64));
        }];
        
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.equalTo(self.titleLabel);
        }];
        
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.mas_right);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
        }];
    }
}

- (void)createCategoryItems {
    
    NSArray *category = self.datas[@"tabInfo"][@"tabList"];
    NSInteger defaultIndex = [self.datas[@"tabInfo"][@"defaultIdx"] integerValue];
    NSMutableArray *temp_dataSource = [NSMutableArray new];
    // update UI
    [category enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EPHomeCategoryListModel *model = [EPHomeCategoryListModel yy_modelWithDictionary:obj];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000 + idx;
        btn.frame = CGRectMake(idx * _btnWidth, self.ep_height - 44, _btnWidth, 44);
        btn.titleLabel.font = FZFontSize(13);
        [btn setTitleColor:RGB(42, 42, 42) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(128, 128, 128) forState:UIControlStateNormal];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.lastSelectedBtn != x) {
                [self.categorySingal sendNext:x];
                [self updateIndicator:x];
            }
        }];
        [self.categoryView addSubview:btn];
        // set default select
        if (defaultIndex == idx) {
            btn.selected = YES;
            self.indicator.center = CGPointMake(btn.center.x, btn.ep_bottom - 6);
            self.lastSelectedBtn = btn;
        }
        [temp_dataSource addObject:model];
    }];
    self.categoryView.contentSize = CGSizeMake(_btnWidth * category.count, self.categoryView.frame.size.height);
    // free memory.
    self.dataSource = temp_dataSource.copy;
    temp_dataSource = nil;
    // update UI.
    [self.defaultSeleted sendNext:RACTuplePack(@(category.count),@(defaultIndex))];
    [self.defaultSeleted sendCompleted];
}

- (void)updateIndicator:(UIButton *)sender {
    
    self.lastSelectedBtn.selected = NO;
    sender.selected = YES;
    
    CGFloat x = 0;
    // 当 sender 的 origin.x + width 小于 当前 scrollView 的显示区域时
    if ((sender.tag - 1000) * _btnWidth < self.categoryView.contentOffset.x + self.categoryView.frame.size.width / 2) {
        // 向右滚动，滚动距离为当前的 sender的中点 - scrllView的中点。
        x = (sender.tag - 1000 + 0.5) * _btnWidth - self.categoryView.frame.size.width / 2;
        // 确保偏移至少为 0.
        x = MAX(x, 0);
    } else {
        x = (sender.tag - 1000 - 0.5) * _btnWidth + self.categoryView.frame.size.width / 2;
        // 确保偏移不能超过 contentsize
        x = MIN(x, self.categoryView.contentSize.width - _btnWidth);
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.categoryView scrollRectToVisible:CGRectMake(x, 0, _btnWidth, 44) animated:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.indicator.center = CGPointMake(sender.center.x, sender.ep_bottom - 6);
        } completion:nil];
    }];
    
    self.lastSelectedBtn = sender;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

// Response to a click event outside the area
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    CGPoint c_point = [self convertPoint:point toView:[UIApplication sharedApplication].keyWindow];
//    CGRect leftMargin = CGRectMake(0, 0, 4 * [UIScreen mainScreen].scale, 44);
//    CGRect rightMargin = CGRectMake(ScreenWidth - 4 * [UIScreen mainScreen].scale, 0, 4 * [UIScreen mainScreen].scale , 44);
//
//    if (CGRectContainsPoint(leftMargin, c_point)) {
//        return self.menuBtn;
//    }
//
//    if (CGRectContainsPoint(rightMargin, c_point)) {
//        return self.searchBtn;
//    }
//    return [super hitTest:point withEvent:event];
//}

// Fix custom titleView width abnormal for iOS 11.
// See: https://stackoverflow.com/questions/44932084/ios-11-navigationitem-titleview-width-not-set
//- (CGSize)intrinsicContentSize {
//    return UILayoutFittingExpandedSize;
//}

#pragma mark - lazy load
#pragma mark -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPFactory label];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [[EPConfigurationManager manager] fontWithKey:@"lobster" size:25.f];
        _titleLabel.textColor = RGB(0, 0, 0);
    }
    return _titleLabel;
}

- (UIButton *)menuBtn {
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn setImage:ImageNamed(@"Action_Menu") forState:UIControlStateNormal];
        self.menuSignal = [_menuBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}

- (UIScrollView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[UIScrollView alloc] init];
        _categoryView.showsHorizontalScrollIndicator = NO;
    }
    return _categoryView;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:ImageNamed(@"bar_ic_search") forState:UIControlStateNormal];
        self.searchSignal = [_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UIView *)indicator {
    if (!_indicator) {
        _indicator = [UIView new];
        _indicator.backgroundColor = UIColor.blackColor;
        _indicator.frame = CGRectMake(UN_SHOW, UN_SHOW, 10, 3);
    }
    return _indicator;
}

- (RACSubject *)categorySingal {
    if (!_categorySingal) {
        _categorySingal = [RACSubject subject];
    }
    return _categorySingal;
}

- (RACSubject *)defaultSeleted {
    if (!_defaultSeleted) {
        _defaultSeleted = [RACSubject subject];
    }
    return _defaultSeleted;
}

@end
