//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 J. All rights reserved.
//

#import "LYNetworkError.h"

@implementation LYNetworkError

- (NSString *)description {
    return [NSString stringWithFormat:@"error code :%d\nerror message: %@\nresp:%@",(int)self.code,self.message,self.response];
}

@end
