//
//  shouDongViewController.m
//  Store
//
//  Created by wb on 15/2/5.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "ShouDongViewController.h"
#import "ShangPinViewController.h"
@interface ShouDongViewController ()

@end

@implementation ShouDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.miaoShuTextView.layer.cornerRadius = 6;
    self.miaoShuTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.miaoShuTextView.layer.borderWidth = 1;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)shangPinAction:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    [textfield resignFirstResponder];
}

- (IBAction)fenLeiAction:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    [textfield resignFirstResponder];
}

- (IBAction)shengChanAction:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    [textfield resignFirstResponder];
}

- (IBAction)tiaoMaAction:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    [textfield resignFirstResponder];
}

- (IBAction)miaoShuAction:(id)sender
{
    UITextView *textView = (UITextView *)sender;
    [textView resignFirstResponder];
}
// 点击 view 手势回收键盘
- (IBAction)huiShouAction:(id)sender
{
    [self.shangPinTestField resignFirstResponder];
    [self.fenLeiTestField resignFirstResponder];
    [self.shengChanTestField resignFirstResponder];
    [self.tiaoMaTestField resignFirstResponder];
    [self.miaoShuTextView resignFirstResponder];
}

- (IBAction)zuoFanHuiAction:(id)sender
{
    //    ShangPinViewController *shangPinVC = [self.navigationController.viewControllers objectAtIndex:0];
    //    [self.navigationController popToViewController:shangPinVC animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
