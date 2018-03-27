//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LYNetworkError : NSError

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id response;

@end
