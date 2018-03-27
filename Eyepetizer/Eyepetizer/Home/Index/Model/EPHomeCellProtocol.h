//
//  EPHomeCellProtocol.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/26.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#ifndef EPHomeCellProtocol_h
#define EPHomeCellProtocol_h
#import "EPHomeCollectionViewModel.h"

@protocol EPHomeCellProtocol

@optional

- (void)bindModel:(EPHomeCollectionViewModel *)model;

- (void)setLineHidden:(BOOL)isHide;

@end

#endif /* EPHomeCellProtocol_h */
