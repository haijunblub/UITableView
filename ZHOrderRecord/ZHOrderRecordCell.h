//
//  ZHOrderRecordCell.h
//  xqshijie
//
//  Created by Admin on 16/7/18.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHMyOrderModel;

@interface ZHOrderRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;

@property (nonatomic, strong) ZHMyOrderModel *orderModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
