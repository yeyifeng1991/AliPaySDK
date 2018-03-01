//
//  ViewController.m
//  cyAliPaySDK
//
//  Created by 叶子 on 2018/2/27.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>

#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h" //加签

#import "WXApi.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)AliPay:(id)sender {
    [self doAPPay];
    NSLog(@"支付宝支付");
}
- (IBAction)AliPayAuth:(id)sender {
    NSLog(@"支付宝授权");
    [self doAPAuth];
}
- (IBAction)AliPayLogin:(id)sender {
    NSLog(@"阿里支付登录");
}
- (IBAction)SinaWeiboLogin:(id)sender {
    NSLog(@"新浪微博支付");
    
}
#pragma mark - 微信登录
- (IBAction)WeChatLogin:(id)sender {
    NSLog(@"微信登录");
    
    //例如微信的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"-----错误-----%@",error);
         }
         
     }];
    
    NSLog(@"--------");

    
    
    
}
- (IBAction)TencentLogin:(id)sender {
    //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"-----错误-----%@",error);
         }
         
     }];
    
    NSLog(@"---QQ登录-----");
}
- (IBAction)AliPayGoPay:(id)sender {
    NSLog(@"支付宝支付");
}

#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017122001008529";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCCwE8Y4qTVrmu6tXSEFXWipiWZxTZevn9TJBdcVzHwX2YAZ9jyZDcTqEp99hp0zZhMfhk940XMofIxj0/Ph+RMMN5bxqX/8XH96Qb1ZBK7pv8E8UouHwSyg4mTS2G/hpgUY2h2ZxwOwL9Kg55Pbfhpt09EiGoCxD33AoAv8Nv1yGaS0/IuAaao8uuegACHcOjDssImYO5YQU+pehWJBF+lHGRmlid+czKAVQe3y5iucDcvnpsxlvys8Kztpf2UL4nTj26i0hh9AXG4Dq/lB9q3G5+xS//ACzmGQD6tseZKPBEfHkhn0zCOQIElBg1FTCuKvn4ciIF0WQX1SmIFHnDDAgMBAAECggEAKGPpy0EwNEYmR04IiUjrxuvWT7MpQYlNYcyTXtYcuiluJA/wZ6hnjy38nP6qW4yrUG3ftEuB413fqEmiGPTcpGCwP9+UpgTa9tnGaYWZd9h1jPxQswCn/dE+bX7q2jRkxF+VBIaDl1cZgJY6EEVjaJzU4tHVFbezgJuIJ8ca28iz410GElLSmz3HNi3jOqarZIEhL57G7PxMzMxcD66nu0evkUZj+M4D0++Zh73+kQa8jI4wb4zkiOqH2HZnOLPoMMxm59CwC6d8rYjYAQvKhxcZthRpWSmjPTl4lTHnzzWIlxcvRda8VxJ1iZfmFWnfkYsQ6a93AuOY77DuqnWVgQKBgQDGtu7GkY8GdbXFbsGmzwp6bPE5ujDlXl2YaFkJXiTmEXU8p8zdRMm52uupwMfXgGAIJWLVbQRvCzIEs5cf5TzU9JEYcyEIBUw40v/pKBvxocURdJVbCJ8Yka1l5zZbkfYSZCZHjwPtBuJ0ixef0Xjy/ls7oY+IKk7mhAXiE1D/wQKBgQCocbPphgEJJ1XANE6jda+VFM4hnwI9gcIbngfVwU14KU1qOJWbNvGHFmPfiO61kkwNDxRyRowaaX+f1J2vBYpCZhLWjnwFGGhfsIx2NyOUYBaF+kZJTD4iKIxzZ19k0i3LfAl2Kvb3lbJiYo2OuvrGZVTm2C/72gjCZWu4aZ/RgwKBgEgnoro9nnaVBWTkW7LrWP2tU0ZH4ntW8ZtmwHXTVoin7C8TKyNpV+qBoLLqCmao+bXbhXDD/ikoIohsgcKWJamaCJmdLHBSJCQ6Eayi4Mqzl/BHqff9QG/WbeUjuKw1aumwremr95v4tP/mhbSFhmqNi6kyeADUhAPWCqDVrMLBAoGAEk1wgBJIcIcuoRjN5qL19hvxneOaKba8saWFMmuzkDfkqoMFdn0M12HObk6BqYcA7nZSAWy68m++J07B52+Rq09OArQus5sIVEVprbqmCgw6xkoAcxxur+V6BVwZGGpiAXczy/w1I4fHfzs4KGcWspH2HLMm25XAV+cPQlVvwSMCgYAVbDY5Qm+VVDtlovDoFZ6y1A9Em59zlCFYO8+Y+K9PgnXS68XufdpxYQwNKtrnRKQS6jo8pC+9Ol2STga1s+8uhoMLXhP1pHyv4qAg7ry0x13QxGbSvOecZnZnEutWEpVk/wg0fl4jolhS0CssJ8SHavDjlKtXn2IkZG89S0848w==";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    NSLog(@"加签之后的string = %@",signedString);
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"ViewController中 reslut = %@",resultDic);
            
        }];
    }
}


#pragma mark -
#pragma mark   ==============点击模拟授权行为==============

- (void)doAPAuth
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"";
    NSString *appID = @"2017122001008529";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCCwE8Y4qTVrmu6tXSEFXWipiWZxTZevn9TJBdcVzHwX2YAZ9jyZDcTqEp99hp0zZhMfhk940XMofIxj0/Ph+RMMN5bxqX/8XH96Qb1ZBK7pv8E8UouHwSyg4mTS2G/hpgUY2h2ZxwOwL9Kg55Pbfhpt09EiGoCxD33AoAv8Nv1yGaS0/IuAaao8uuegACHcOjDssImYO5YQU+pehWJBF+lHGRmlid+czKAVQe3y5iucDcvnpsxlvys8Kztpf2UL4nTj26i0hh9AXG4Dq/lB9q3G5+xS//ACzmGQD6tseZKPBEfHkhn0zCOQIElBg1FTCuKvn4ciIF0WQX1SmIFHnDDAgMBAAECggEAKGPpy0EwNEYmR04IiUjrxuvWT7MpQYlNYcyTXtYcuiluJA/wZ6hnjy38nP6qW4yrUG3ftEuB413fqEmiGPTcpGCwP9+UpgTa9tnGaYWZd9h1jPxQswCn/dE+bX7q2jRkxF+VBIaDl1cZgJY6EEVjaJzU4tHVFbezgJuIJ8ca28iz410GElLSmz3HNi3jOqarZIEhL57G7PxMzMxcD66nu0evkUZj+M4D0++Zh73+kQa8jI4wb4zkiOqH2HZnOLPoMMxm59CwC6d8rYjYAQvKhxcZthRpWSmjPTl4lTHnzzWIlxcvRda8VxJ1iZfmFWnfkYsQ6a93AuOY77DuqnWVgQKBgQDGtu7GkY8GdbXFbsGmzwp6bPE5ujDlXl2YaFkJXiTmEXU8p8zdRMm52uupwMfXgGAIJWLVbQRvCzIEs5cf5TzU9JEYcyEIBUw40v/pKBvxocURdJVbCJ8Yka1l5zZbkfYSZCZHjwPtBuJ0ixef0Xjy/ls7oY+IKk7mhAXiE1D/wQKBgQCocbPphgEJJ1XANE6jda+VFM4hnwI9gcIbngfVwU14KU1qOJWbNvGHFmPfiO61kkwNDxRyRowaaX+f1J2vBYpCZhLWjnwFGGhfsIx2NyOUYBaF+kZJTD4iKIxzZ19k0i3LfAl2Kvb3lbJiYo2OuvrGZVTm2C/72gjCZWu4aZ/RgwKBgEgnoro9nnaVBWTkW7LrWP2tU0ZH4ntW8ZtmwHXTVoin7C8TKyNpV+qBoLLqCmao+bXbhXDD/ikoIohsgcKWJamaCJmdLHBSJCQ6Eayi4Mqzl/BHqff9QG/WbeUjuKw1aumwremr95v4tP/mhbSFhmqNi6kyeADUhAPWCqDVrMLBAoGAEk1wgBJIcIcuoRjN5qL19hvxneOaKba8saWFMmuzkDfkqoMFdn0M12HObk6BqYcA7nZSAWy68m++J07B52+Rq09OArQus5sIVEVprbqmCgw6xkoAcxxur+V6BVwZGGpiAXczy/w1I4fHfzs4KGcWspH2HLMm25XAV+cPQlVvwSMCgYAVbDY5Qm+VVDtlovDoFZ6y1A9Em59zlCFYO8+Y+K9PgnXS68XufdpxYQwNKtrnRKQS6jo8pC+9Ol2STga1s+8uhoMLXhP1pHyv4qAg7ry0x13QxGbSvOecZnZnEutWEpVk/wg0fl4jolhS0CssJ8SHavDjlKtXn2IkZG89S0848w==";;
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少pid或者appID或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
#pragma mark - 进行加签操作
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
#pragma mark - 微信支付
- (IBAction)WeChatPay:(id)sender {
    /*
     NSLog(@"微信支付");
     //需要创建这个支付对象
     PayReq *req   = [[PayReq alloc] init];
     //由用户微信号和AppID组成的唯一标识，用于校验微信用户
     req.openID = @"";
     
     // 商家id，在注册的时候给的
     req.partnerId = @"";
     
     // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
     req.prepayId  = @"";
     
     // 根据财付通文档填写的数据和签名
     //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
     req.package   = @"";
     
     // 随机编码，为了防止重复的，在后台生成
     req.nonceStr  = @"";
     
     // 这个是时间戳，也是在后台生成的，为了验证支付的
     NSString * stamp = @"";
     req.timeStamp = stamp.intValue;
     
     // 这个签名也是后台做的
     req.sign = @"";
     
     //发送请求到微信，等待微信返回onResp
     [WXApi sendReq:req];
     */
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
