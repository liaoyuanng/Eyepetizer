//
//  EPConfiguration.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/26.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPConfigurationManager.h"

NSString * const EPCellTypeBanner = @"banner";
NSString * const EPCellTypeBanner2 = @"banner2";
NSString * const EPCellTypeTextCard = @"textCard";
NSString * const EPCellTypeFollowCard = @"followCard";
NSString * const EPCellTypeSubFollowCard = @"FollowCard";
NSString * const EPCellTypeVideoSmallCard = @"videoSmallCard";
NSString * const EPCellTypeSquareCard = @"squareCardCollection";
NSString * const EPCellTypeHorizontalScroll = @"horizontalScrollCard";
NSString * const EPCellTypeBriefCard = @"briefCard";
NSString * const EPCellUnknowType = @"unknowType";

static inline NSDictionary *FontMap() {
    return @{@"lobster":@"Lobster 1.4",@"bigBold":@"FZLTZCHJW--GB1-0"};
}

static inline NSDictionary *cellHeightMap() {
    return @{EPCellTypeBanner:@((ScreenWidth - 30) * 0.59),
             EPCellTypeTextCard:@(21 + 44),
             EPCellTypeVideoSmallCard:@(Scale(105)),
             EPCellTypeSquareCard:@(70.f + 15.f + 0.58 * (ScreenWidth - 30) + 85),
             EPCellTypeFollowCard:@(70.f + 15.f + 0.58 * (ScreenWidth - 30)),
             EPCellTypeHorizontalScroll:@(0.58 * (ScreenWidth - 30)),
             EPCellTypeBriefCard:@(72),
             EPCellUnknowType:@(0)};
}

@implementation EPConfigurationManager

+ (instancetype)manager {
    static EPConfigurationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EPConfigurationManager alloc] _init];
    });
    return manager;
}

- (instancetype)_init {
    if (self = [super init]) {
        
    }
    return self;
}

- (UIFont *)fontWithKey:(NSString *)key size:(CGFloat)size {
    if (!key) return nil;
    return [UIFont fontWithName:FontMap()[key] size:size];
}

- (CGFloat)cellHeightByType:(NSString *)type {
    if (!type) return 0.0;
    
    return [cellHeightMap()[type] floatValue];
}

- (BOOL)verificationCellType:(NSString *)type {
    return cellHeightMap()[type];
}

@end
