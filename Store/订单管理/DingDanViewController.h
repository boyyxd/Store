//
//  DingDanViewController.h
//  Store
//
//  Created by mm on 15/1/26.
//  Copyright (c) 2015年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface DingDanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>



@property (weak, nonatomic) IBOutlet UITabBarItem *dingDanItem;
@property (weak, nonatomic) IBOutlet UITextField *souSuoTextField;



@property (weak, nonatomic) IBOutlet UIScrollView *caiDanScrollView;//菜单栏

@property (weak, nonatomic) IBOutlet UITableView *xinDingdanTableView;//新订单tableView

//@property (weak, nonatomic) IBOutlet UITableView *shangPinTableView;//新订单view

@property (weak, nonatomic) IBOutlet UIButton *xinDingDanButton;
@property (weak, nonatomic) IBOutlet UIButton *yiJieShouButton;
@property (weak, nonatomic) IBOutlet UIButton *yiWanChengButton;
@property (weak, nonatomic) IBOutlet UIButton *liShiButton;
//@property (weak, nonatomic) IBOutlet UIView *buJieShouView;//点击不接受弹出的view
//@property (weak, nonatomic) IBOutlet UIButton *jieShouButton;//接受按钮
//
//@property (weak, nonatomic) IBOutlet UIButton *buJieShouButton;//不接受按钮
//
//
//@property (weak, nonatomic) IBOutlet UIButton *meiShiJianButton;
//
//@property (weak, nonatomic) IBOutlet UIButton *shangPinBuZuButton;
//
//@property (weak, nonatomic) IBOutlet UIButton *buZaiFanWeiButton;
//@property (weak, nonatomic) IBOutlet UIButton *othersButton;


@property (weak, nonatomic) IBOutlet UIScrollView *yiJieShouView;//已接受View界面
@property (weak, nonatomic) IBOutlet UITableView *yiSongDaTableView;//第一个tableView
@property (weak, nonatomic) IBOutlet UITableView *yiJieShouTableView;//第二个tableView
@property (weak, nonatomic) IBOutlet UIButton *yiSongDaButton;//已送达按钮2

@property (weak, nonatomic) IBOutlet UIView *yiWanChengView;
@property (weak, nonatomic) IBOutlet UIView *liShiDingDanView;
@property (weak, nonatomic) IBOutlet UIButton *dingDanZhuangTaiButton;
@property (weak, nonatomic) IBOutlet UIView *dingDanZhuangTaiView;
@property (weak, nonatomic) IBOutlet UIButton *yiWanCheng2Button;
@property (weak, nonatomic) IBOutlet UIButton *weiJieDan2Button;
@property (weak, nonatomic) IBOutlet UIButton *weiWanCheng2Button;
@property (weak, nonatomic) IBOutlet UIButton *shaiXuanButton;//右筛选


//查询View下 对应的控件
@property (weak, nonatomic) IBOutlet UIView *chaXunView;
@property (weak, nonatomic) IBOutlet UITextField *dingDanHaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouHuoRenTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouHuoShiJianTextField;
@property (weak, nonatomic) IBOutlet UITextField *dingDanZongJiaMinTextField;
@property (weak, nonatomic) IBOutlet UITextField *dingDanZongJiaMaxTextField;

//查询View下 几个回收键盘
- (IBAction)dingDanHaoHuiShouAction:(id)sender;
- (IBAction)shouHuoRenHuiShouAction:(id)sender;
- (IBAction)dingDanShiJianHuiShouAction:(id)sender;
- (IBAction)dingDanZongJiaMinHuiShouAction:(id)sender;
- (IBAction)dingDanZongJiaMaxHuiShouAction:(id)sender;

//查询界面 下的两个 Button
@property (weak, nonatomic) IBOutlet UIButton *chongZhiButton;
@property (weak, nonatomic) IBOutlet UIButton *queDingButton;
- (IBAction)chongZhiAction:(id)sender;
- (IBAction)queDIngAction:(id)sender;


- (IBAction)tapHuiShouJianPan:(id)sender;//点击回收键盘
- (IBAction)backAction:(id)sender;//点击左上返回
- (IBAction)shaiXuanAction:(id)sender;//右筛选
- (IBAction)huiShouJianPan:(id)sender;
- (IBAction)xinDingDanAction:(id)sender;
- (IBAction)yiJieshouAction:(id)sender;
- (IBAction)yiWanChengAction:(id)sender;
- (IBAction)liShiAction:(id)sender;
//- (IBAction)buJieShouAction:(id)sender;
//- (IBAction)jieShouAction:(id)sender;
//- (IBAction)meiShiJianAction:(id)sender;
//- (IBAction)shangPinBuZuAction:(id)sender;
//
//- (IBAction)buZaiFanWeiAction:(id)sender;
//- (IBAction)othersAction:(id)sender;
- (IBAction)dingDanZhuangTaiAction:(id)sender;
- (IBAction)yiWanCheng2Action:(id)sender;
- (IBAction)weiJieDan2Action:(id)sender;
- (IBAction)weiWanCheng2Action:(id)sender;



@end
