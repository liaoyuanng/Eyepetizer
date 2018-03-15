//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 J. All rights reserved.
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

#define tab_list @"v5/index/tab/list"
#define categroy_list @"v5/category/list"


/***************************/
/////
/////   user
/////
/***************************/
#pragma mark - user

#define user_login          @"/XBInterface/login"
#define user_info           @"/XBInterface/uinfo"
#define user_forgetpwd      @"/XBInterface/forgetpwd"
#define user_modifyPwd      @"/XBInterface/uppwd"
#define user_sendMessage    @"/XBInterface/sms"
#define user_updateInfo     @"/XBInterface/updata"
#define user_bindphone      @"/XBInterface/bingphone"
#define user_pay_orderNO    @"/XBInterface/addordermember"
#define user_pay_pay        @"/XBInterface/addpay"


/***************************/
///// find
/////
/***************************/
#pragma mark - find
#define find_met @"/XBInterface/met"
#define find_addnote @"/XBInterface/addnote"
#define find_upnote @"/XBInterface/upnote"
#define find_searchnote @"/XBInterface/searchnote"
#define find_searchReply @"/XBInterface/searchReply"
#define find_reply @"/XBInterface/addreply"
#define find_addcollect @"/XBInterface/addcollect"
#define find_delcollect @"/XBInterface/delcollect"
#define find_upnote @"/XBInterface/upnote"
#define find_searchnotedetail @"/XBInterface/searchnotedetail"

/***************************/
/////   personal center
/////
/***************************/
#pragma mark - personal center
#define center_opinion  @"/XBInterface/opinion"
#define center_querycollect @"/XBInterface/querycollect"
#define center_vipInfo @"/XBInterface/memberproduct"
#define center_functintro @"http://yuhb.baiduux.com/h5/xbinstruction.html"
#define center_vintro @"http://yuhb.baiduux.com/h5/version.html"
#define center_aboutus @"http://www.zgxueban.com"
/***************************/
/////
/////   message
/////
/***************************/
#pragma mark - message

#define msg_query @"/XBInterface/querypush"

#pragma mark - code list

#define HTTP_SUCCESS 1  // 请求成功
#define HTTP_CODE_ERROR 4 // 验证码错误
#define HTTP_TOEKN_INVALID 5 // token 失效
#define HTTP_SERVER_ERROR 500 // 服务器错误


#define REQUEST_SUCCESS !responseObject[@"errorCode"]

#endif /* NBNetworkMacro_h */
