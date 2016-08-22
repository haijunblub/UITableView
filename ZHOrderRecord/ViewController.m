//
//  ViewController.m
//  ZHOrderRecord
//
//  Created by Admin on 16/7/18.
//  Copyright © 2016年 王海军. All rights reserved.
//

#import "ViewController.h"
#import "ZHMyOrderModel.h"
#import "ZHOrderRecordCell.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kButtonHeight 49
#define kCellHeight 44
#define kNumberOfRows 3 // 大于3行折叠
#define kDefaultNumberOfRows 2 // 默认显示2行
static NSString *const kButtonStatus = @"buttonStatus";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    [self createDataArray];
    
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleRefresh:(UIRefreshControl *)sender
{
    // 模拟数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

- (void)createDataArray
{
    for (NSInteger i = 0; i < 6; i++) {
        ZHMyOrderModel *item = [ZHMyOrderModel modelWithPayTime:[NSString stringWithFormat:@"2016-07-18 15:55:5%ld", i] payAmount:[NSString stringWithFormat:@"￥2016%ld", i] payStatus:i % 2 ? YES : NO];
        [self.dataArray addObject:item];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count > kNumberOfRows) {
        if (self.isOpen) {
            return self.dataArray.count;
        } else {
            return kDefaultNumberOfRows;
        }
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHOrderRecordCell *cell = [ZHOrderRecordCell cellWithTableView:tableView];
    cell.orderModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIFont *font_14 = [UIFont systemFontOfSize:14];
    CGFloat padding = 12;
    CGFloat timeLabelW = 145;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, timeLabelW, kCellHeight)];
    timeLabel.text = @"支付时间";
    timeLabel.font = font_14;
    [view addSubview:timeLabel];
    
    CGFloat statusLabelW = 65;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH - padding - statusLabelW, 0, statusLabelW, kCellHeight)];
    statusLabel.text = @"状态";
    statusLabel.font = font_14;
    [view addSubview:statusLabel];
    
    CGFloat amountLabelX = CGRectGetMaxX(timeLabel.frame);
    CGFloat amountLabelW = UISCREEN_WIDTH - 2 * padding - timeLabelW - statusLabelW;
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(amountLabelX, 0, amountLabelW, kCellHeight)];
    amountLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.font = font_14;
    amountLabel.text = @"支付金额";
    [view addSubview:amountLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    if (self.dataArray.count >= kNumberOfRows) {
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, UISCREEN_WIDTH, kCellHeight);
        UIImage *normalImage;
        if (self.isOpen) {
            normalImage = [UIImage imageNamed:@"order_detail_down"];
        } else {
            normalImage = [UIImage imageNamed:@"order_detail_up"];
        }
        
        [button setImage:normalImage forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(showOrderRecord:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
    
    
    return view;
}

- (void)showOrderRecord:(UIButton *)sender
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL isSelected = [userDefault boolForKey:kButtonStatus];
    if (isSelected) {
        sender.selected = !isSelected;
    } else {
        sender.selected = !sender.selected;
    }
    
    [userDefault setBool:sender.selected forKey:kButtonStatus];
    [userDefault synchronize];

    if (sender.selected) {
        self.isOpen = YES;
    } else {
        self.isOpen = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - get 方法

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT - 64 - kButtonHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [self.tableView addSubview:self.refreshControl];
    }
    return _refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
