//
//  EPHomeCollectionViewModel.h
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/21.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

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
//@property (nonatomic, assign) NSInteger time;
//
//@property (nonatomic, assign) BOOL showHateVideo;

@end

//@interface EPHomeCollectionViewModel_ItemList : NSObject
//
//@property (nonatomic, copy) NSArray *itemList;
//
//@end

@interface EPHomeCollectionViewModel_Content : NSObject



@end

@interface EPHomeCollectionViewModel_Data : NSObject

@property (nonatomic, copy) NSString *dataType;

@property (nonatomic, copy) NSArray *itemList;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *adTrack;

@property (nonatomic, assign) NSInteger shade;

@property (nonatomic, strong) EPHomeCollectionViewModel_Header *header;



//@property (nonatomic, strong) EPHomeCollectionViewModel_Content *content;

@end

//@interface EPHomeCollectionViewModel_Data_ItemList_Data_Content_Data_Consumption : NSObject
//
//@property (nonatomic, assign) NSInteger collectionCount;
//
//@property (nonatomic, assign) NSInteger shareCount;
//
//@property (nonatomic, assign) NSInteger replyCount;
//
//@end
//
//@interface EPHomeCollectionViewModel_Data_ItemList_Data_Content_Data : NSObject
//
//@property (nonatomic, copy) NSString *dataType;
//
//@property (nonatomic, assign) NSInteger idx;
//
//@property (nonatomic, copy) NSString *title;
//
//@property (nonatomic, copy) NSString *description;
//
//@property (nonatomic, copy) NSString *library;
//
//@property (nonatomic, copy) NSArray *tag;
//
//@property (nonatomic, strong) EPHomeCollectionViewModel_Data_ItemList_Data_Content_Data_Consumption *consumption;
//
//@property (nonatomic, copy) NSString *resourceType;
//
//@property (nonatomic, copy) NSString *slogan;
//
//
//
//@end
//
//@interface EPHomeCollectionViewModel_Data_ItemList_Data_Content : NSObject
//
//@property (nonatomic, copy) NSString *type;
//
//@property (nonatomic, strong) EPHomeCollectionViewModel_Data_ItemList_Data_Content_Data *data;
//
//@property (nonatomic, copy) NSString *tag;
//
//@property (nonatomic, assign) NSInteger idx;
//
//@property (nonatomic, assign) NSInteger adIndex;
//
//@end
//
//@interface EPHomeCollectionViewModel_Data_ItemList_Data : NSObject
//
//@property (nonatomic, copy) NSString *dataType;
//
//@property (nonatomic, assign) NSInteger count;
//
//@property (nonatomic, copy) NSString *adTrack;
//
//@property (nonatomic, strong) EPHomeCollectionViewModel_Header *header;
//
//@property (nonatomic, copy)
//
////@property (nonatomic, strong) EPHomeCollectionViewModel_Content *content;
//
//@end
//
//
//@interface EPHomeCollectionViewModel_Data_ItemList : NSObject
//
//@property (nonatomic, copy) NSString *type;
//
//@property (nonatomic, strong) EPHomeCollectionViewModel_Data *data;
//
//@property (nonatomic, assign) NSInteger count;
//
//@property (nonatomic, copy) NSString *adTrack;
//
//@end

@interface EPHomeCollectionViewModel : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, assign) NSInteger adIndex;

@property (nonatomic, strong) EPHomeCollectionViewModel_Data *data;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end
