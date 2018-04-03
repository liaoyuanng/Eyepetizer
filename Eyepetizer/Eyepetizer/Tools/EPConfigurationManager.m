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
NSString * const EPCellTypeVideoSmallCard = @"videoSmallCard";
NSString * const EPCellTypeSquareCard = @"squareCardCollection";
NSString * const EPCellTypeHorizontalScroll = @"horizontalScrollCard";
NSString * const EPCellTypeBriefCard = @"briefCard";
NSString * const EPCellUnknowType = @"unknowType";
NSString * const EPCellVideoCollectionWithBrief = @"videoCollectionWithBrief";

static inline NSDictionary *FontMap() {
    return @{@"lobster":@"Lobster 1.4",@"bigBold":@"FZLTZCHJW--GB1-0"};
}

static inline NSDictionary *cellHeightMap() {
    return @{EPCellTypeBanner:@(CGSizeMake(ScreenWidth * 0.928, (ScreenWidth - 30) * 0.59)),
             EPCellTypeTextCard:@(CGSizeMake(ScreenWidth, 21 + 44)),
             EPCellTypeVideoSmallCard:@(CGSizeMake(ScreenWidth,Scale(105))),
             EPCellTypeSquareCard:@(CGSizeMake(ScreenWidth, 70.f + 15.f + 0.58 * (ScreenWidth - 30) + 85)),
             EPCellTypeFollowCard:@(CGSizeMake(ScreenWidth * 0.928, 70.f + 15.f + 0.58 * (ScreenWidth - 30))),
             EPCellTypeHorizontalScroll:@(CGSizeMake(ScreenWidth, 0.58 * (ScreenWidth - 30))),
             EPCellTypeBriefCard:@(CGSizeMake(ScreenWidth, 72)),
             EPCellVideoCollectionWithBrief:@(CGSizeMake(ScreenWidth, 100))};
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

- (CGSize)cellSizeByType:(NSString *)type {
    if (!type) return CGSizeZero;
    
    return [cellHeightMap()[type] CGSizeValue];
}

- (BOOL)verificationCellType:(NSString *)type {
    return cellHeightMap()[type];
}

@end
