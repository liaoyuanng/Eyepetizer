//
//  EPSearchModel.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPSearchModel.h"

@interface EPSearchModel ()

@property (nonatomic, strong) RACCommand *requestCommand;

@end

@implementation EPSearchModel

- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [LYNetwork networkRequestType:GET url:api_hotspot paras:nil completion:^(id response) {
                    [subscriber sendNext:response];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _requestCommand;
}

@end
