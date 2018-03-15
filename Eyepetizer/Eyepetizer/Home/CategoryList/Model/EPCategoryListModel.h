//
//  EPCategoryListModel.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/14.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class EPCategoryFollowModel;

@interface EPCategoryFollowModel : NSObject

@property (nonatomic, assign) NSInteger followed;

@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, copy) NSString *itemType;

@end

@interface EPCategoryModel : NSObject

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, copy) NSString *dataType;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *iconType;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *ifPgc;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) EPCategoryFollowModel *follow;

@end


@interface EPCategoryListModel : NSObject

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *adIndex;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) EPCategoryModel *data;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end
