//
//  EPBannerCollectionCell.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/27.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPHomeCellProtocol.h"

@interface EPBannerCollectionCell : UICollectionViewCell<EPHomeCellProtocol>

@property (nonatomic, assign) BOOL hideLine;

@end
