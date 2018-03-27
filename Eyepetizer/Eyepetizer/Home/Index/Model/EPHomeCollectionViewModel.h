//
//  EPHomeCollectionViewModel.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/21.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

@class EPHomeCollectionViewModel_Data;
@class EPHomeCollectionViewModel_Header;
@class EPHomeCollectionViewModel_Content;
@class EPHomeCollectionViewModel_Data_Cover;

@interface EPHomeCollectionViewModel : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, assign) NSInteger adIndex;

@property (nonatomic, strong) EPHomeCollectionViewModel_Data *data;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end

////////////////////////////////////////////////////////////////////////////////////

@interface EPHomeCollectionViewModel_Data : NSObject

@property (nonatomic, copy) NSString *dataType;

@property (nonatomic, copy) NSArray *itemList;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *library;

@property (nonatomic, copy) NSString *resourceType;

@property (nonatomic, copy) NSString *slogan;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, assign) NSInteger shade;

@property (nonatomic, strong) EPHomeCollectionViewModel_Header *header;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) EPHomeCollectionViewModel_Data_Cover *cover;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, strong) EPHomeCollectionViewModel_Content *content;

@end

////////////////////////////////////////////////////////////////////////////////////

@interface EPHomeCollectionViewModel_Header : NSObject

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *font;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *subTitleFont;

@property (nonatomic, copy) NSString *textAlign;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *labelList;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *desc;
//
@property (nonatomic, assign) NSInteger time;
//
@property (nonatomic, assign) BOOL showHateVideo;

@end

////////////////////////////////////////////////////////////////////////////////////

@interface EPHomeCollectionViewModel_Content : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) EPHomeCollectionViewModel_Data *data;

@property (nonatomic, assign) NSInteger idx;

//@property (nonatomic, assign) NSInteger adTrack;

@end

////////////////////////////////////////////////////////////////////////////////////

@interface EPHomeCollectionViewModel_Data_Cover : NSObject

@property (nonatomic, copy) NSString *feed;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *blurred;

@property (nonatomic, copy) NSString *sharing;

@property (nonatomic, copy) NSString *homepage;

@end

