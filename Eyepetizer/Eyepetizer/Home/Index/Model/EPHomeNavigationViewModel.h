//
//  EPHomeNavigationViewModel.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/12.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPHomeNavigationViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end
