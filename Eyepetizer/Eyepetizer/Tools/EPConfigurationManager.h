//
//  EPConfiguration.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/26.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const EPCellTypeBanner;
FOUNDATION_EXTERN NSString * const EPCellTypeTextCard;
FOUNDATION_EXTERN NSString * const EPCellTypeSquareCard;
FOUNDATION_EXTERN NSString * const EPCellTypeFollowCard;
FOUNDATION_EXTERN NSString * const EPCellTypeVideoSmallCard;


@interface EPConfigurationManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)manager;

/**
 get font by name

 @param key Font name
 @return UIFont object.
 */
- (UIFont *)fontWithKey:(NSString *)key size:(CGFloat)size;

/**
 get cell row height by type
 */
- (CGFloat)cellHeightByType:(NSString *)type;

@end
