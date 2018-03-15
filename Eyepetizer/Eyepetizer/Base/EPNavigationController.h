//
//  EPNavigationController.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPNavigationController : UINavigationController

/**
 hide 1px line in navigationBar bottom, default is NO.
 */
@property (nonatomic, assign, getter=isLineHidden) BOOL lineHidden;

@end
