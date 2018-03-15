//
//  EPHomeNavigationViewModel.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/12.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeNavigationViewModel.h"

@interface EPHomeNavigationViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestCommand;

@end

@implementation EPHomeNavigationViewModel


- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [LYNetwork networkRequestType:GET url:tab_list paras:nil completion:^(id response) {
                    [subscriber sendNext:response];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
            return singal;
        }];
    }
    return _requestCommand;
}

@end
