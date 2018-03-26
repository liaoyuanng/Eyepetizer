//
//  EPHomeCollectionViewModel.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/21.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeCollectionViewModel.h"

@implementation EPHomeCollectionViewModel_Header

YY_Mapper(@{@"desc":@"description"})

@end

@implementation EPHomeCollectionViewModel_Data

YY_Container(@{@"itemList":[EPHomeCollectionViewModel class]})
YY_Mapper((@{@"idx":@"id",@"desc":@"description"}))

@end

@implementation EPHomeCollectionViewModel_Data_Cover
@end

@implementation EPHomeCollectionViewModel_Content

//YY_Container(@{@"itemList":[EPHomeCollectionViewModel class]})
YY_Mapper((@{@"idx":@"id"}))

@end




@interface EPHomeCollectionViewModel ()

@property (nonatomic, strong) RACCommand *requestCommand;

@end

@implementation EPHomeCollectionViewModel

YY_Mapper(@{@"idx":@"id"})
YY_IgnoreProperties(@[@"requestCommand"])

- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [LYNetwork networkRequestType:GET url:input paras:nil completion:^(id response) {
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
