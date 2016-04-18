//
//  xinDingDanTableViewCell.h
//  Store
//
//  Created by 杨小东 on 15/4/10.
//  Copyright (c) 2015年 王博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface xinDingDanTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *xddScrollView;//新订单view
@property (weak, nonatomic) IBOutlet UITableView *shangPinTableView;//新订单view
@property (weak, nonatomic) IBOutlet UIView *buJieShouView;//点击不接受弹出的view
@property (weak, nonatomic) IBOutlet UIButton *jieShouButton;//接受按钮

@property (weak, nonatomic) IBOutlet UIButton *buJieShouButton;//不接受按钮

@property (weak, nonatomic) IBOutlet UILabel *dingDanNumberLabel;

@property (weak, nonatomic) IBOutlet UIButton *meiShiJianButton;

@property (weak, nonatomic) IBOutlet UIButton *shangPinBuZuButton;

@property (weak, nonatomic) IBOutlet UIButton *buZaiFanWeiButton;
@property (weak, nonatomic) IBOutlet UIButton *othersButton;


- (IBAction)buJieShouAction:(id)sender;
- (IBAction)jieShouAction:(id)sender;
- (IBAction)meiShiJianAction:(id)sender;
- (IBAction)shangPinBuZuAction:(id)sender;

- (IBAction)buZaiFanWeiAction:(id)sender;
- (IBAction)othersAction:(id)sender;
@end
