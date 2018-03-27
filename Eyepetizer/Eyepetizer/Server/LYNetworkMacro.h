//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#ifndef LYNetworkMacro_h
#define LYNetworkMacro_h

#define BaseURL @"https://baobab.kaiyanapp.com/api/"

/***************************/
/////
/////   Home
/////
/***************************/
#pragma mark - Home

#define api_tab_list @"v5/index/tab/list"
#define api_categroy_list @"v5/category/list"
#define api_hotspot @"v3/queries/hot"


#pragma mark - code list

#define HTTP_SUCCESS 200  // 请求成功
#define HTTP_CODE_ERROR 4 // 验证码错误
#define HTTP_TOEKN_INVALID 5 // token 失效
#define HTTP_SERVER_ERROR 500 // 服务器错误


#define REQUEST_SUCCESS !responseObject[@"errorCode"]

#endif /* NBNetworkMacro_h */
