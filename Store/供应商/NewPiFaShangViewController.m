//
//  NewPiFaShangViewController.m
//  Store
//
//  Created by wb on 15/2/5.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "NewPiFaShangViewController.h"

@interface NewPiFaShangViewController ()

@end

@implementation NewPiFaShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)piFaAction:(id)sender
{
    UITextField * testfield = (UITextField *)sender;
    [testfield resignFirstResponder];
}

- (IBAction)lianXiAction:(id)sender
{
    UITextField * testfield = (UITextField *)sender;
    [testfield resignFirstResponder];
}

- (IBAction)dianHuaAction:(id)sender
{
    UITextField * testfield = (UITextField *)sender;
    [testfield resignFirstResponder];
}

- (IBAction)miaoShuAction:(id)sender
{
    UITextView * textView = (UITextView *)sender;
    [textView resignFirstResponder];
    
}

- (IBAction)huiShouJianPanAction:(id)sender
{
    [self.piFaShangTestField resignFirstResponder];
    [self.lianXiRenTestField resignFirstResponder];
    [self.dianHuaTestField resignFirstResponder];
    [self.miaoShuTextView resignFirstResponder];
}

- (IBAction)zuoFanHuiAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
