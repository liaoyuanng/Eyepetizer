//
//  EPSearchViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/15.
//  Copyright © 2018年 J. All rights reserved.
//

#import "EPSearchViewController.h"
#import "EPSearchBar.h"
#import "EPSearchTitleLabel.h"

static NSString * const hotspotCell = @"com.imliaoyuan.hotspot";

@interface EPSearchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) EPSearchBar *searchBar;

@property (nonatomic, strong) EPSearchTitleLabel *titleLabel;

@property (nonatomic, strong) UITableView *hotspot;

@end

@implementation EPSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI {
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.hotspot];
}

#pragma mark - lazy load
#pragma mark -

- (EPSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[EPSearchBar alloc] initWithFrame:self.navigationController.navigationBar.frame];
        @weakify(self);
        [_searchBar.cancel subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.searchBar endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _searchBar;
}

- (EPSearchTitleLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EPSearchTitleLabel new];
        _titleLabel.frame = CGRectMake(0, 64, ScreenWidth, 65);
        _titleLabel.text = @"热搜关键词";
        _titleLabel.textColor = RGB(68, 68, 68);
        _titleLabel.font = FZFontSize(21);
    }
    return _titleLabel;
}

- (UITableView *)hotspot {
    if (!_hotspot) {
        _hotspot = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 65, ScreenWidth, ScreenHeight - 65 - 64) style:UITableViewStylePlain];
        _hotspot.delegate = self;
        _hotspot.dataSource = self;
        _hotspot.rowHeight = 40.f;
        _hotspot.separatorColor = RGB(236, 236, 236);
        [_hotspot registerClass:[UITableViewCell class] forCellReuseIdentifier:hotspotCell];
    }
    return _hotspot;
}

#pragma mark - table view delegate && datasource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotspotCell forIndexPath:indexPath];
    cell.textLabel.textColor = RGB(70, 135, 215);
    cell.textLabel.text = @"123";
    cell.textLabel.font = FZFontSize(13);
    return cell;
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
