//
//  EPFactory.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPFactory.h"

@implementation EPFactory

+ (UILabel *)label {
    return [self labelWithText:nil];
}

+ (UILabel *)labelWithText:(NSString *)aText {
    return [self labelWithText:aText textColor:UIColor.blackColor];
}

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor {
    return [self labelWithText:aText textColor:aColor font:FontSize(15)];
}

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor font:(UIFont *)aFont {
    return [self labelWithText:aText textColor:aColor font:aFont lineBreakMode:NSLineBreakByWordWrapping];
}

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor font:(UIFont *)aFont lineBreakMode:(NSLineBreakMode)aMode {
    UILabel *label = [UILabel new];
    label.text = aText;
    label.textColor = aColor;
    label.font = aFont;
    label.lineBreakMode = aMode;
    return label;
}

@end
