//
//  EPCategoryTableViewCell.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/14.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPCategoryListModel;

@interface EPCategoryTableViewCell : UITableViewCell

- (void)bindModel:(EPCategoryListModel *)model;

@end
