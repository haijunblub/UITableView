//
//  ZHOrderRecordCell.m
//  xqshijie
//
//  Created by Admin on 16/7/18.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import "ZHOrderRecordCell.h"
#import "ZHMyOrderModel.h"

@implementation ZHOrderRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ZHOrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHOrderRecordCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHOrderRecordCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setOrderModel:(ZHMyOrderModel *)orderModel
{
    _orderModel = orderModel;
    
    self.payTimeLabel.text = orderModel.notify_time;
    self.payAmountLabel.text = orderModel.pay_amount;
    self.payStatusLabel.text = orderModel.status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
