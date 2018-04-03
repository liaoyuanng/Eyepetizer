//
//  EPVideoBriefCell.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/30.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPHomeCellProtocol.h"

@interface EPVideoBriefCell : UICollectionViewCell<EPHomeCellProtocol>

@property (nonatomic, strong) RACSignal *followAction;

@end
