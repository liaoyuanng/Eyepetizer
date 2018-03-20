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
#import "EPNormalCell.h"
#import "EPTextOnlyCell.h"
#import "EPScrollCell.h"

@interface EPHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *continerView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation EPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self customNavigationBar];
}

- (void)customNavigationBar {
    
    EPHomeNavigationView *navBar = [[EPHomeNavigationView alloc] init];
    navBar.frame = self.navigationController.navigationBar.frame;
    @weakify(self);
    [navBar.menuSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[EPCategoryListViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    [navBar.searchSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        EPNavigationController *nav = [[EPNavigationController alloc] initWithRootViewController:[EPSearchViewController new]];
        nav.lineHidden = YES;
        [self presentViewController:nav animated:NO completion:nil];
    }];
    [navBar.categorySingal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
    }];
    EPHomeNavigationViewModel *viewModel = [EPHomeNavigationViewModel new];
    [[viewModel.requestCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        navBar.dataSource = (NSDictionary *)x;
    }];
    [viewModel.requestCommand.errors subscribeNext:^(NSError * _Nullable x) {

    }];

    self.navigationItem.titleView = navBar;
}

- (void)initUI {
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
//    self.collectionView.backgroundColor = UIColor.whiteColor;
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[EPScrollCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.view addSubview:self.collectionView];
    
    self.continerView = [[UIScrollView alloc] init];
    self.continerView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 44);
    self.continerView.backgroundColor = UIColor.redColor;
    self.continerView.pagingEnabled = YES;
//    self.continerView.showsVerticalScrollIndicator = NO;
    
    self.continerView.contentSize = CGSizeMake(ScreenWidth * 10, ScreenHeight - 64 - 444);
    [self.view addSubview:self.continerView];
}

// CGSizeMake(ScreenWidth, (ScreenWidth - 30) * 0.58 + 70 + 15);

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, 360);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.titleLabel.text = @"近期热门";
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
