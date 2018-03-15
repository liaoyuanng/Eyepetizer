//
//  EPSearchTitleLabel.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/15.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPSearchTitleLabel.h"

@implementation EPSearchTitleLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {25,15,0,0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
