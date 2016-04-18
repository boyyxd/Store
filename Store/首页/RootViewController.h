//
//  RootViewController.h
//  Store
//
//  Created by MM on 15/1/26.
//  Copyright (c) 2015年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RootViewController : UIViewController<UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITabBarItem *shouYeItem;

@property (weak, nonatomic) IBOutlet UIButton *shouYeXinDingDanButton;
//@property (weak, nonatomic) IBOutlet UISwitch *yingYeSwitch;

- (IBAction)xinDingDan:(id)sender;
//- (IBAction)yingYeSwitchAction:(id)sender;

@end
