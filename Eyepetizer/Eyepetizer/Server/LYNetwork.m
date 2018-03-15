//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//


#import "LYNetwork.h"
#import <AFNetworking/AFNetworking.h>
//#import <JSONModel/JSONModel.h>
//#import "NSDictionary+NBDictionaryToString.h"
//#import "UIViewController+LYActive.h"
//#import <Toast/UIView+Toast.h>
#import "LYNetworkMacro.h"
#import "LYNetworkParameter.h"
//#import "NSData+Base64.h"
//#import <SVProgressHUD.h>

 NSString * const LYNetworkErrorMessage = @"com.ly.network.error.message";
 NSString * const LYNetworkErrorResponse = @"com.ly.network.error.response";

@interface LYNetwork ()

@property (nonatomic, strong) NSURL *baseUrl;

@property (nonatomic, copy) NSString *baseUrlStr;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LYNetwork

+ (instancetype)manager {
    static LYNetwork *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[LYNetwork alloc] _init];
    });
    return network;
}

- (instancetype)_init {
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.baseUrl = [NSURL URLWithString:BaseURL];
    self.baseUrlStr = BaseURL;
}

#pragma mark - public
#pragma mark

+ (void)networkRequestType:(LYNetworkRequestType)type url:(NSString *)aUrl paras:(LYNetworkParameter *)paras completion:(void (^)(id response))completion failure:(void(^)(NSError *error))failure {
    return [[LYNetwork manager] networkRequestType:type url:aUrl paras:paras completion:completion failure:failure];
}

- (void)networkRequestType:(LYNetworkRequestType)type url:(NSString *)aUrl paras:(LYNetworkParameter *)paras completion:(void (^)(id response))completion failure:(void(^)(NSError *error))failure {
    
    if (type == GET) {
        [_manager GET:[self.baseUrl URLByAppendingPathComponent:aUrl].absoluteString parameters:paras.result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            if (REQUEST_SUCCESS) {
                !completion ? : completion(responseObject);
            } else {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:[responseObject[@"errorCode"] integerValue] userInfo:@{LYNetworkErrorMessage:responseObject[@"errorMessage"],LYNetworkErrorResponse:responseObject}];
                !failure ? : failure(error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ? : failure(error);
        }];
    } else {
        
        [_manager POST:[self.baseUrl URLByAppendingPathComponent:aUrl].absoluteString parameters:paras.result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"~~~%@",responseObject);
            if (REQUEST_SUCCESS) {
                !completion ? : completion(responseObject);
            } else if ([responseObject[@"status"] integerValue] == HTTP_TOEKN_INVALID){
//                [[LYUserCenter defaultCenter] logout];
//                LYLoginViewController *loginVC = (LYLoginViewController *)[UIViewController activeViewController];
//                [loginVC.view makeToast:@"登录已失效，请重新登录" duration:1.f position:[NSValue valueWithCGPoint:CGPointMake(ScreenWidth / 2, ScreenHeight - 150)]];
            } else {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:[responseObject[@"errorCode"] integerValue] userInfo:@{LYNetworkErrorMessage:responseObject[@"errorMessage"],LYNetworkErrorResponse:responseObject}];
                !failure ? : failure(error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ? : failure(error);
        }];
    }
}

- (void)resetBaseUrl:(NSURL *)newUrl {
    if (!newUrl) return;
    
    self.baseUrl = newUrl;
    self.baseUrlStr = newUrl.absoluteString;
}

@end
