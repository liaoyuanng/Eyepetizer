//
//  EPHomeNavigationView.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPHomeCategoryListModel.h"

@interface EPHomeNavigationView : UIView

/**
 menu item action
 */
@property (nonatomic, strong, readonly) RACSignal *menuSignal;

/**
 search item action
 */
@property (nonatomic, strong, readonly) RACSignal *searchSignal;

/**
 category items action
 */
@property (nonatomic, strong, readonly) RACSubject *categorySingal;

/**
 update UI, set total of category items, and default select index.
 */
@property (nonatomic, strong, readonly) RACSubject *defaultSeleted;

@property (nonatomic, copy, readonly) NSArray<EPHomeCategoryListModel *> *dataSource;

- (void)updateIndex:(NSInteger)index;

- (void)bindModel:(NSDictionary *)datas;

@end
