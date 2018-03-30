//
//  EPNavigationController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPNavigationController.h"
#import "UIImage+EPColor.h"

@interface EPNavigationController ()<UINavigationControllerDelegate>

@end

@implementation EPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lineHidden = NO;
   
    self.navigationBar.barTintColor = RGB(243, 243, 243);
}

- (void)setLineHidden:(BOOL)lineHidden {
    _lineHidden = lineHidden;
    if (lineHidden) {
        [self.navigationBar setShadowImage:[UIImage new]];
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationBar setShadowImage:[UIImage imageWithColor:RGB(236, 236, 236)]];
    }
}

// hide navigation bar when view appear.
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    [self setNavigationBarHidden:YES animated:YES];
//}


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
