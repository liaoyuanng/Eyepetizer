//
//  EPCategoryListModel.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "EPCategoryListModel.h"

@interface EPCategoryListModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestCommand;

@end

@implementation EPCategoryListModel

YY_Mapper(@{@"idx":@"id"})
YY_IgnoreProperties(@[@"requestCommand"])

- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [LYNetwork networkRequestType:GET url:categroy_list paras:nil completion:^(id response) {
                    [subscriber sendNext:response[@"itemList"]];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                return  nil;
            }];
            return singal;
        }];
    }
    return _requestCommand;
}

@end

@implementation EPCategoryModel


YY_Mapper((@{@"idx":@"id",@"desc":@"description"}))

@end

@implementation EPCategoryFollowModel
@end
