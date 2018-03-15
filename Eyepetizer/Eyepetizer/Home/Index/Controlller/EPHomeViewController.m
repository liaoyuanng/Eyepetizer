//
//  EPHomeViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 J. All rights reserved.
//

#import "EPHomeViewController.h"
#import "EPHomeNavigationView.h"
#import "EPHomeNavigationViewModel.h"
#import "EPCategoryListViewController.h"
#import "EPSearchViewController.h"

@interface EPHomeViewController ()

@end

@implementation EPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
}

- (void)dismiss {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[EPCategoryListViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
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
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[EPSearchViewController new]];
        [nav.navigationBar setShadowImage:[UIImage new]];
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
