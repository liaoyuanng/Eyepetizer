//
//  EPSearchViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/15.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPSearchViewController.h"
#import "EPSearchBar.h"
#import "EPSearchTitleLabel.h"
#import "EPHotSpotTableViewCell.h"
#import "EPSearchModel.h"

static NSString * const hotspotCell = @"com.imliaoyuan.hotspot";

@interface EPSearchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) EPSearchBar *searchBar;

@property (nonatomic, strong) EPSearchTitleLabel *titleLabel;

@property (nonatomic, strong) UITableView *hotspot;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation EPSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self fetchData];
}

- (void)initUI {
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.hotspot];
}

- (void)fetchData {
    EPSearchModel *model = [EPSearchModel new];
    @weakify(self);
    [[model.requestCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.dataSource = x;
        [self.hotspot reloadData];
    }];
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
        _titleLabel.font = FZFontSize(22);
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
        _hotspot.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动时隐藏键盘。
        [_hotspot registerClass:[EPHotSpotTableViewCell class] forCellReuseIdentifier:hotspotCell];
    }
    return _hotspot;
}

#pragma mark - table view delegate && datasource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPHotSpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotspotCell forIndexPath:indexPath];
    cell.label.text = self.dataSource[indexPath.row];
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
