//
//  ShangPinViewController.h
//  Store
//
//  Created by wb on 15/1/27.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangPinViewController : UIViewController


//搜索框
@property (weak, nonatomic) IBOutlet UITextField *souSuoTextField;

//scrollView上的四个按钮
@property (weak, nonatomic) IBOutlet UIButton *yiShangJiaButton;
@property (weak, nonatomic) IBOutlet UIButton *diKuCunButton;
@property (weak, nonatomic) IBOutlet UIButton *shangPinKuButton;
@property (weak, nonatomic) IBOutlet UIButton *tianJiaShangPinButton;
@property (weak, nonatomic) IBOutlet UIView *tianJiaView;

//scrollView上的四个按钮对应的四个View
@property (weak, nonatomic) IBOutlet UIView *yiShangJiaView;
@property (weak, nonatomic) IBOutlet UIView *diKuCunView;
@property (weak, nonatomic) IBOutlet UIView *shangPinKuView;
@property (weak, nonatomic) IBOutlet UIView *tianJiaShangPinView;


//第一个按钮下的五个Button
@property (weak, nonatomic) IBOutlet UIButton *shangPin1Button;
@property (weak, nonatomic) IBOutlet UIButton *jiaGe1Button;
@property (weak, nonatomic) IBOutlet UIButton *kuCun1Button;
@property (weak, nonatomic) IBOutlet UIButton *zhuangTai1Button;
@property (weak, nonatomic) IBOutlet UIButton *fenLei1Button;

//点击状态1按钮弹出的控件

@property (weak, nonatomic) IBOutlet UIView *zhuangTai1View;
@property (weak, nonatomic) IBOutlet UIButton *shangJia11Button;
@property (weak, nonatomic) IBOutlet UIButton *xiaJia11Button;
- (IBAction)shangJia11Action:(id)sender;
- (IBAction)xiaJia11Action:(id)sender;



//第二个按钮下的五个Button

@property (weak, nonatomic) IBOutlet UIButton *shangPin2Button;
@property (weak, nonatomic) IBOutlet UIButton *jiaGe2Button;
@property (weak, nonatomic) IBOutlet UIButton *kuCun2Button;
@property (weak, nonatomic) IBOutlet UIButton *zhuangTai2Button;
@property (weak, nonatomic) IBOutlet UIButton *zengJia2Button;

//点击状态2按钮弹出的控件
@property (weak, nonatomic) IBOutlet UIView *zhuangTai2View;
@property (weak, nonatomic) IBOutlet UIButton *shangJia22Button;
@property (weak, nonatomic) IBOutlet UIButton *xiaJia22Button;
- (IBAction)shangJia22Action:(id)sender;
- (IBAction)xiaJia22Action:(id)sender;


//第三个按钮下的四个Button
@property (weak, nonatomic) IBOutlet UIButton *shangPin3Button;
@property (weak, nonatomic) IBOutlet UIButton *shengCan3Button;
@property (weak, nonatomic) IBOutlet UIButton *fenLei3Button;
@property (weak, nonatomic) IBOutlet UIButton *shangJia3Button;

//第四个按钮下的二个Button
@property (weak, nonatomic) IBOutlet UIButton *shangPin4Button;
@property (weak, nonatomic) IBOutlet UIButton *tianJia4Button;
//查询View下对应的 控件



////scrollView上的四个按钮 对应的四个方法
- (IBAction)yiShangJiaAction:(id)sender;
- (IBAction)diKuCunAction:(id)sender;
- (IBAction)shangPinKuAction:(id)sender;
- (IBAction)tianJiaShangPinAction:(id)sender;


- (IBAction)souSuoTextFiledHuiShouAction:(id)sender;
- (IBAction)tapViewAction:(id)sender; //点击View 回收键盘

- (IBAction)backAction:(id)sender; // 返回


//第一个按钮下的五个Button 对应的五个方法
- (IBAction)shangPin1Action:(id)sender;
- (IBAction)jiaGe1Action:(id)sender;
- (IBAction)kuCun1Action:(id)sender;
- (IBAction)zhuangTai1Action:(id)sender;
- (IBAction)fenLei1Action:(id)sender;


// 第二个按钮下的五个Button 对应的五个方法
- (IBAction)shangPin2Action:(id)sender;
- (IBAction)jiaGe2Action:(id)sender;
- (IBAction)kuCun2Action:(id)sender;
- (IBAction)zhuangTai2Action:(id)sender;
- (IBAction)zengJia2Action:(id)sender;

//第三个按钮下的四个Button 对应的四个方法
- (IBAction)shangPin3Action:(id)sender;
- (IBAction)shengCan3Action:(id)sender;
- (IBAction)fenLei3Action:(id)sender;
- (IBAction)shangJia3Action:(id)sender;

//第四个按钮下的二个Button 对应的方法
- (IBAction)shangPin4Action:(id)sender;
- (IBAction)tianJia4Action:(id)sender;



@end
