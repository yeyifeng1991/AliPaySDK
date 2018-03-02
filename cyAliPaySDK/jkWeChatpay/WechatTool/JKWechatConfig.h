//
//  JKWechatConfig.h
//  CIOTimes
//  简书
//  Created by 王冲 on 2017/8/8.
//  Copyright © 2017年 wangchao. All rights reserved.
//

#ifndef JKWechatConfig_h
#define JKWechatConfig_h

#import "WXApi.h"
#import "JKApiManager.h"
#import "JKWechatPayHandler.h"  //微信支付调用类
#import "JKWechatSignAdaptor.h" //微信签名工具类
#import "XMLDictionary.h"       //XML转换工具类

/**
 -----------------------------------
 微信支付需要配置的参数
 -----------------------------------
 */

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define MXWechatAPPID       @"wx0b12464246787cb1"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define MXWechatAPPSecret   @"42bbf9ebf99a402f564acda1b373114c"
// 微信支付商户号
#define MXWechatMCHID       @"1499466722"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define MXWechatPartnerKey  @"PvO45hIE3xYj5NS0o3VyQicVfmRGTEmn"


/**
 -----------------------------------
 微信下单接口
 -----------------------------------
 */

#define kUrlWechatPay       @"https://api.mch.weixin.qq.com/pay/unifiedorder"


/**
 -----------------------------------
 统一下单请求参数键值
 -----------------------------------
 */

#define WXAPPID         @"appid"            // 应用id
#define WXMCHID         @"mch_id"           // 商户号
#define WXNONCESTR      @"nonce_str"        // 随机字符串
#define WXSIGN          @"sign"             // 签名
#define WXBODY          @"body"             // 商品描述
#define WXOUTTRADENO    @"out_trade_no"     // 商户订单号
#define WXTOTALFEE      @"total_fee"        // 总金额
#define WXEQUIPMENTIP   @"spbill_create_ip" // 终端IP
#define WXNOTIFYURL     @"notify_url"       // 通知地址
#define WXTRADETYPE     @"trade_type"       // 交易类型
#define WXPREPAYID      @"prepay_id"        // 预支付交易会话

#endif /* JKWechatConfig_h */
