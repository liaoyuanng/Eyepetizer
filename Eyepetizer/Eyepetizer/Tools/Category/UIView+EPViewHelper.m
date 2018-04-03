//
//  UIView+EPViewHelper.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/30.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "UIView+EPViewHelper.h"

@implementation UIView (EPViewHelper)

- (CGFloat)ep_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)ep_height {
    return self.frame.size.height;
}

@end
