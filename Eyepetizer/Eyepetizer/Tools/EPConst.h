//
//  EPConst.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#define ImageNamed(_x) [UIImage imageNamed:_x]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Scale(_x) (_x / (375.0 / ScreenWidth))
#define FontSize(_x) [UIFont systemFontOfSize:_x]
#define FZFontSize(_x) [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:_x]
#define FZXFontSize(_x) [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:_x]
#define RGB(r,g,b) RGBA(r,g,b,1)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define URL(_x) [NSURL URLWithString:_x]
#define PlaceHolderColor RGB(237, 237, 237)

#define YY_IgnoreProperties(properties) \
+ (NSArray *)modelPropertyBlacklist { \
    return properties; \
}

#define YY_Mapper(properties) \
+ (NSDictionary *)modelCustomPropertyMapper { \
    return properties; \
}

#define YY_Container(properties) \
+ (NSDictionary *)modelContainerPropertyGenericClass { \
    return properties; \
}

