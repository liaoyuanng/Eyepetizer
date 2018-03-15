//
//  EPTabBarController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 J. All rights reserved.
//

#import "EPTabBarController.h"
#import "EPNavigationController.h"

@interface EPTabBarController ()

@end

@implementation EPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViewControllers];
}

- (void)initSubViewControllers {
    NSArray *classes = @[@"EPHomeViewController",
                         @"EPFollowViewController",
                         @"EPNotificationViewController",
                         @"EPMineViewController"];
    
    NSArray *images_nor = @[@"ic_tab_home",
                            @"ic_tab_follow",
                            @"ic_tab_2",
                            @"ic_tab_4"];
    
    NSArray *images_sel = @[@"ic_tab_home_selected",
                            @"ic_tab_follow_selected",
                            @"ic_tab_2_selected",
                            @"ic_tab_4_selected"];
    
    NSMutableArray *vcs = [NSMutableArray new];
    
    [classes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cls = NSClassFromString(obj);
        UIViewController *vc = [cls new];
        EPNavigationController *nav = [[EPNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                                 image:[ImageNamed(images_nor[idx]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[ImageNamed(images_sel[idx]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        vc.tabBarItem = tabBarItem;
        [vcs addObject:nav];
    }];

    self.tabBar.backgroundColor = UIColor.whiteColor;
    self.viewControllers = vcs;
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
