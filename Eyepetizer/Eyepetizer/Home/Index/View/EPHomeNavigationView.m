//
//  EPHomeNavigationView.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeNavigationView.h"

#define BtnWidth 55
#define UN_SHOW -1000

static const NSTimeInterval animationDuration = 0.2;

@interface EPHomeNavigationView ()
// Why contentView?
// navigationItem's titleView have a mrigin(4.7 inch is 8px, 5.5 inch is 12px), so we need remove this margin.
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *menuBtn;

@property (nonatomic, strong) UIScrollView *categoryView;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, strong, readwrite) RACSignal *menuSignal;

@property (nonatomic, strong, readwrite) RACSignal *searchSignal;

@property (nonatomic, strong, readwrite) RACSubject *categorySingal;

@property (nonatomic, strong, readwrite) RACSubject *defaultSeleted;

@property (nonatomic, strong) UIButton *lastSelectedBtn;

@property (nonatomic, strong) NSDictionary *datas;

@property (nonatomic, copy) NSArray<EPHomeCategoryListModel *> *dataSource;

@end

@implementation EPHomeNavigationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.menuBtn];
    [self.contentView addSubview:self.categoryView];
    [self.contentView addSubview:self.searchBtn];
    [self.categoryView addSubview:self.indicator];
    
    [self addConstraint];
}

- (void)addConstraint {
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(self.menuBtn);
    }];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.menuBtn.mas_right);
        make.right.equalTo(self.searchBtn.mas_left);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView);
    }];
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

- (void)createCategoryItems {
    NSArray *category = self.datas[@"tabInfo"][@"tabList"];
    NSInteger defaultIndex = [self.datas[@"tabInfo"][@"defaultIdx"] integerValue];
    NSMutableArray *temp_dataSource = [NSMutableArray new];
    // update UI
    [category enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EPHomeCategoryListModel *model = [EPHomeCategoryListModel yy_modelWithDictionary:obj];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000 + idx;
        btn.frame = CGRectMake(idx * BtnWidth, 0, BtnWidth, self.frame.size.height);
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
            self.indicator.center = CGPointMake(btn.center.x, 38);
            self.lastSelectedBtn = btn;
        }
        [temp_dataSource addObject:model];
    }];
    self.categoryView.contentSize = CGSizeMake(BtnWidth * category.count, self.categoryView.frame.size.height);
    // free memory.
    self.dataSource = temp_dataSource.copy;
    temp_dataSource = nil;
    // update UI.
    [self.defaultSeleted sendNext:RACTuplePack(@(category.count),@(defaultIndex))];
    [self.defaultSeleted sendCompleted];
}

- (void)updateIndicator:(UIButton *)sender {
    sender.selected = YES;
    self.lastSelectedBtn.selected = NO;
    
    CGFloat x = 0;
    // 当 sender 的 origin.x + width 小于 当前 scrollView 的显示区域时
    if ((sender.tag - 1000) * BtnWidth < self.categoryView.contentOffset.x + self.categoryView.frame.size.width / 2) {
        // 向右滚动，滚动距离为当前的 sender的中点 - scrllView的中点。
        x = (sender.tag - 1000 + 0.5) * BtnWidth - self.categoryView.frame.size.width / 2;
        // 确保偏移至少为 0.
        x = MAX(x, 0);
    } else {
        x = (sender.tag - 1000 - 0.5) * BtnWidth + self.categoryView.frame.size.width / 2;
        // 确保偏移不能超过 contentsize
        x = MIN(x, self.categoryView.contentSize.width - BtnWidth);
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.categoryView scrollRectToVisible:CGRectMake(x, 0, BtnWidth, 44) animated:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.indicator.center = CGPointMake(sender.center.x, 38);
        } completion:nil];
    }];
    
    self.lastSelectedBtn = sender;
}

// Response to a click event outside the area
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint c_point = [self convertPoint:point toView:[UIApplication sharedApplication].keyWindow];
    CGRect leftMargin = CGRectMake(0, 0, 4 * [UIScreen mainScreen].scale, 44);
    CGRect rightMargin = CGRectMake(ScreenWidth - 4 * [UIScreen mainScreen].scale, 0, 4 * [UIScreen mainScreen].scale , 44);
    
    if (CGRectContainsPoint(leftMargin, c_point)) {
        return self.menuBtn;
    }
    
    if (CGRectContainsPoint(rightMargin, c_point)) {
        return self.searchBtn;
    }
    return [super hitTest:point withEvent:event];
}

// Fix custom titleView width abnormal for iOS 11.
// See: https://stackoverflow.com/questions/44932084/ios-11-navigationitem-titleview-width-not-set
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

#pragma mark - lazy load
#pragma mark -

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.frame = CGRectMake(-4 * [UIScreen mainScreen].scale, 0, ScreenWidth, 44);
        _contentView.backgroundColor = RGB(243, 243, 243);
    }
    return _contentView;
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
