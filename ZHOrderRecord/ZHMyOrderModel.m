//
//  ZHMyOrderModel.m
//  xqshijie
//
//  Created by Admin on 16/7/13.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import "ZHMyOrderModel.h"

@implementation ZHMyOrderModel

+ (instancetype)modelWithPayTime:(NSString *)payTime payAmount:(NSString *)amount payStatus:(BOOL)isSuccess
{
    ZHMyOrderModel *orderModer = [[self alloc] init];
    orderModer.notify_time = payTime;
    orderModer.pay_amount = amount;
    if (isSuccess) {
        orderModer.status = @"支付成功";
    } else {
        orderModer.status = @"支付失败";
    }
    
    return orderModer;
}

@end
