//
//  EPCategoryListViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "EPCategoryListViewController.h"
#import "EPCategoryTableViewCell.h"
#import "EPCategoryListModel.h"

static NSString * const cellID = @"com.imliaoyuan.categorylist";
static const float autoScrollArea = 40.f + 64.f;
static const float autoScrollStep = 5;

// 找遍了震动方式，都没有找到和原版 App 类似的手感。。。
static inline void impact() {
    if (@available(iOS 10.0, *)) {
        UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
        [generator selectionChanged];
    }
}

@interface EPCategoryListViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation EPCategoryListViewController

#warning no cache!!!

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray new];

    self.tableView.rowHeight = 72.f;
    self.tableView.allowsSelection = NO;
    self.tableView.separatorColor = RGB(236, 236, 236);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.tableView registerClass:[EPCategoryTableViewCell class] forCellReuseIdentifier:cellID];
    [self setupNavigationBar];
    [self addMoveGesture];
    [self fetchData];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"置顶分类排序";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                      NSFontAttributeName:FZFontSize(20)}];

    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[ImageNamed(@"Action_close") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(completedAndDismiss)];
    
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil
                                                                           action:nil];
    fixed.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[fixed, leftItem];
}

// Reference:http://www.raywenderlich.com/63089/cookbook-moving-table-view-cells-with-a-long-press-gesture
- (void)addMoveGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    longPress.minimumPressDuration = 0.2;

    @weakify(self);
    [[longPress rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);        
        static UIView *snapshot = nil;
        static NSIndexPath *sourceIndexPath = nil;
        CGPoint point = [x locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        switch (x.state) {
            case UIGestureRecognizerStateBegan:
            {
                if (indexPath) {
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    snapshot = [cell snapshotViewAfterScreenUpdates:YES];
                    snapshot.center = cell.center;
                    [self.tableView addSubview:snapshot];
                    sourceIndexPath = indexPath;
                    cell.hidden = YES;
                    impact();
                }
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                CGPoint center = snapshot.center;
                center.y = point.y;
                snapshot.center = center;
                if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                    [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                    sourceIndexPath = indexPath;
                    impact();
                }
                if (point.y > self.tableView.frame.size.height + self.tableView.contentOffset.y - autoScrollArea) {
                    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, MIN(self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.contentOffset.y + autoScrollStep))];
                }
                
                if ((point.y < self.tableView.contentOffset.y + autoScrollArea)) {
                    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, MAX(-64, self.tableView.contentOffset.y - autoScrollStep))];
                }
            }
                break;
            case UIGestureRecognizerStateEnded:
            {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
                [UIView animateWithDuration:0.3 animations:^{
                    snapshot.center = cell.center;
                } completion:^(BOOL finished) {
                    cell.hidden = NO;
                    [snapshot removeFromSuperview];
                    snapshot = nil;
                    impact();
                }];
            }
                break;
            default:
                break;
        }
    }];
    [self.tableView addGestureRecognizer:longPress];
}

- (void)fetchData {
    EPCategoryListModel *model = [EPCategoryListModel new];
    @weakify(self);
    [[model.requestCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.dataSource = ((NSArray *)x).mutableCopy;
        [self.tableView reloadData];
    }];
}

- (void)completedAndDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell bindModel:[EPCategoryListModel yy_modelWithDictionary:self.dataSource[indexPath.row]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"******✅[%@](%p) dealloc,good job!******",[self class],self);
}

@end
