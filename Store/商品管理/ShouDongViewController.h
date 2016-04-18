//
//  shouDongViewController.h
//  Store
//
//  Created by wb on 15/2/5.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouDongViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *shouDongView;

//  5个 testfield
@property (weak, nonatomic) IBOutlet UITextField *shangPinTestField;
@property (weak, nonatomic) IBOutlet UITextField *fenLeiTestField;
@property (weak, nonatomic) IBOutlet UITextField *shengChanTestField;
@property (weak, nonatomic) IBOutlet UITextField *tiaoMaTestField;
@property (weak, nonatomic) IBOutlet UITextView *miaoShuTextView;


//5个 testfield 收回键盘
- (IBAction)shangPinAction:(id)sender;
- (IBAction)fenLeiAction:(id)sender;
- (IBAction)shengChanAction:(id)sender;
- (IBAction)tiaoMaAction:(id)sender;
- (IBAction)miaoShuAction:(id)sender;
//点击屏幕View 回收键盘
- (IBAction)huiShouAction:(id)sender;





- (IBAction)zuoFanHuiAction:(id)sender;



@end
