//
//  EPHomeViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeViewController.h"
#import "EPHomeNavigationView.h"
#import "EPHomeNavigationViewModel.h"
#import "EPCategoryListViewController.h"
#import "EPSearchViewController.h"
#import "EPFollowCardCell.h"
#import "EPTextOnlyCell.h"
#import "EPScrollCell.h"
#import "EPHomeCollectionController.h"

@interface EPHomeViewController ()<UIScrollViewDelegate> {
    NSInteger _lastSelected;
}

@property (nonatomic, strong) UIScrollView *continerView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) EPHomeNavigationView *navigationView;

@property (nonatomic, strong) NSMutableDictionary *childViewControllsMap;

@end

@implementation EPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self customNavigationBar];
    [self fetchData];
}

- (void)customNavigationBar {

    self.navigationView = [[EPHomeNavigationView alloc] init];
    self.navigationView.frame = self.navigationController.navigationBar.frame;
    self.navigationItem.titleView = self.navigationView;
}

- (void)fetchData {
    
    @weakify(self);
    // menu btn action
    [self.navigationView.menuSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[EPCategoryListViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    // search btn action
    [self.navigationView.searchSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        EPNavigationController *nav = [[EPNavigationController alloc] initWithRootViewController:[EPSearchViewController new]];
        nav.lineHidden = YES;
        [self presentViewController:nav animated:NO completion:nil];
    }];
    // category btns action
    [self.navigationView.categorySingal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UIButton *btn = (UIButton *)x;
        self.continerView.contentOffset = CGPointMake(ScreenWidth * (btn.tag - 1000), 0);
        [self scrollViewDidEndDecelerating:self.continerView];
    }];
    // set continerView content size and default select.
    [self.navigationView.defaultSeleted subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSNumber *total, NSNumber *selected) = x;
        self.continerView.contentSize = CGSizeMake(total.integerValue * ScreenWidth, ScreenHeight - 44);
        self.continerView.contentOffset = CGPointMake(ScreenWidth * selected.integerValue, 0);
        // initiative call.
        [self scrollViewDidEndDecelerating:self.continerView];
        _lastSelected = selected.integerValue;
    }];
    // get data from server
    EPHomeNavigationViewModel *viewModel = [EPHomeNavigationViewModel new];
    [[viewModel.requestCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationView bindModel:x];
    }];
    [viewModel.requestCommand.errors subscribeNext:^(NSError * _Nullable x) {

    }];
}

- (void)initUI {
    
    self.continerView = [[UIScrollView alloc] init];
    self.continerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44);
    self.continerView.backgroundColor = UIColor.whiteColor;
    self.continerView.pagingEnabled = YES;
    self.continerView.delegate = self;
    self.continerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.continerView];
}

#pragma mark - scrollView delegate
#pragma mark -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger index = (NSInteger)floor(fabs(scrollView.contentOffset.x) / ScreenWidth);
    
    // Ignore case.
    if (_lastSelected == index) return;
    _lastSelected = index;
    
    [self.navigationView updateIndex:index];
    
    if (self.childViewControllsMap[@(index)]) {
        EPHomeCollectionController *viewController = self.childViewControllsMap[@(index)];
        [viewController willMoveToParentViewController:self];
        return;
    }
    // See about https://imliaoyuan.com/2016/08/30/%E5%A6%82%E4%BD%95%E6%AD%A3%E7%A1%AE%E6%B7%BB%E5%8A%A0child_view_controller.html
    EPHomeCollectionController *viewcontroller = [[EPHomeCollectionController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    viewcontroller.apiUrl = self.navigationView.dataSource[index].apiUrl;
    viewcontroller.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:viewcontroller];
    viewcontroller.view.frame = CGRectMake(index * ScreenWidth, 64, ScreenWidth, ScreenHeight - 44 - 64);
    [self.continerView addSubview:viewcontroller.view];
    [viewcontroller willMoveToParentViewController:self];
    [self.childViewControllsMap setObject:viewcontroller forKey:@(index)];
}

- (NSMutableDictionary *)childViewControllsMap {
    if (!_childViewControllsMap) {
        _childViewControllsMap = [NSMutableDictionary new];
    }
    return _childViewControllsMap;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
