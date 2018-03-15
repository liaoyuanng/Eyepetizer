//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LYNetworkError.h"

FOUNDATION_EXTERN NSString * const LYNetworkErrorMessage;
FOUNDATION_EXTERN NSString * const LYNetworkErrorResponse;

@class LYNetworkParameter;

typedef NS_ENUM(NSInteger, LYNetworkRequestType) {
    GET,
    POST
};


@interface LYNetwork : NSObject

@property (nonatomic, strong, readonly) NSURL *baseUrl;

@property (nonatomic, copy, readonly) NSString *baseUrlStr;

+ (instancetype)manager;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 reset base url

 @param newUrl new base url
 */
- (void)resetBaseUrl:(NSURL *)newUrl;

+ (void)networkRequestType:(LYNetworkRequestType)type url:(NSString *)aUrl paras:(LYNetworkParameter *)paras completion:(void (^)(id response))completion failure:(void(^)(NSError *error))failure;

- (void)networkRequestType:(LYNetworkRequestType)type url:(NSString *)aUrl paras:(LYNetworkParameter *)paras completion:(void (^)(id response))completion failure:(void(^)(NSError *error))failure;


@end
