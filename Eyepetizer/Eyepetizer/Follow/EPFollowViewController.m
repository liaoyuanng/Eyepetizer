//
//  EPFollowViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPFollowViewController.h"
#import "EPNavigationView.h"

@interface EPFollowViewController ()

@property (nonatomic, strong) EPNavigationView *navigationView;

@end

@implementation EPFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView = [[EPNavigationView alloc] init];
    self.navigationView.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 108);
    self.navigationView.type = EPNavigationViewTypeNormal;
    self.navigationView.title = @"Subscription";
    [self.view addSubview:self.navigationView];
    // Do any additional setup after loading the view.
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
