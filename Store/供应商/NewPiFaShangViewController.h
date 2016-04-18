//
//  NewPiFaShangViewController.h
//  Store
//
//  Created by wb on 15/2/5.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPiFaShangViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *NewView;

//四个testfield
@property (weak, nonatomic) IBOutlet UITextField *piFaShangTestField;
@property (weak, nonatomic) IBOutlet UITextField *lianXiRenTestField;
@property (weak, nonatomic) IBOutlet UITextField *dianHuaTestField;

@property (weak, nonatomic) IBOutlet UITextView *miaoShuTextView;



// 四个testfield 点击收回键盘
- (IBAction)piFaAction:(id)sender;
- (IBAction)lianXiAction:(id)sender;
- (IBAction)dianHuaAction:(id)sender;
- (IBAction)miaoShuAction:(id)sender;
- (IBAction)huiShouJianPanAction:(id)sender;

- (IBAction)zuoFanHuiAction:(id)sender;




@end
