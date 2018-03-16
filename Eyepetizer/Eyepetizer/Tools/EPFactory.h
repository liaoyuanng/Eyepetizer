//
//  EPFactory.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPFactory : NSObject

+ (UILabel *)label;

+ (UILabel *)labelWithText:(NSString *)aText;

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor;

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor font:(UIFont *)aFont;

+ (UILabel *)labelWithText:(NSString *)aText textColor:(UIColor *)aColor font:(UIFont *)aFont lineBreakMode:(NSLineBreakMode)aMode;

@end
