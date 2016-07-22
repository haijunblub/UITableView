//
//  ZHMyOrderModel.h
//  xqshijie
//
//  Created by Admin on 16/7/13.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMyOrderModel : NSObject

/** 支付金额 **/
@property (nonatomic, copy) NSString *pay_amount;
/** 支付通知时间 **/
@property (nonatomic, copy) NSString *notify_time;
/** 支付状态 **/
@property (nonatomic, copy) NSString *status;

+ (instancetype)modelWithPayTime:(NSString *)payTime payAmount:(NSString *)amount payStatus:(BOOL)isSuccess;

@end
