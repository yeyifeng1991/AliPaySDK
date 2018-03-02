//
//  JKApiManager.m
//  CIOTimes
//
//  Created by 王冲 on 2017/8/8.
//  Copyright © 2017年 wangchao. All rights reserved.
//

#import "JKApiManager.h"

@implementation JKApiManager

#pragma mark - 单列

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static JKApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[JKApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = nil;
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSLog(@"%@",@"支付失败");
                break;
        }
    }
}


@end
