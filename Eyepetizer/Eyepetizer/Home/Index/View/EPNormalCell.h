//
//  EPNormalCell.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPHomeCellProtocol.h"

@interface EPNormalCell : UICollectionViewCell<EPHomeCellProtocol>

@property (nonatomic, strong, readonly) RACSignal *share;

@property (nonatomic, assign) BOOL hideLine;

@end
