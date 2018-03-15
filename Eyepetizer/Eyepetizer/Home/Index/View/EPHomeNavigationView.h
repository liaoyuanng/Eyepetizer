//
//  EPHomeNavigationView.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPHomeNavigationView : UIView

@property (nonatomic, strong, readonly) RACSignal *menuSignal;

@property (nonatomic, strong, readonly) RACSignal *searchSignal;

@property (nonatomic, strong) RACSubject *categorySingal;

@property (nonatomic, copy) NSDictionary *dataSource;

@end
