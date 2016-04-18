//
//  GongYingShangViewController.m
//  Store
//
//  Created by wb on 15/1/27.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "GongYingShangViewController.h"

@interface GongYingShangViewController ()

@end

@implementation GongYingShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
//    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"10(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"10.png"]];
    [self souSuoSheZhi];
}

- (void)souSuoSheZhi
{
    UIView * leftView = [[UIView alloc]init];
    
    leftView.frame = CGRectMake(0, 0, 30, self.souSuoTextField.frame.size.height);//Textfiled左view
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];//Textfiled右Button
    rightButton.frame=CGRectMake(0, 0, 70, self.souSuoTextField.frame.size.height);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"15.png"] forState:UIControlStateNormal];
    
    self.souSuoTextField.leftView = leftView;
    self.souSuoTextField.leftViewMode = UITextFieldViewModeAlways;
    self.souSuoTextField.rightView = rightButton;
    self.souSuoTextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.souSuoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapViewAction:(id)sender
{
    [self.souSuoTextField resignFirstResponder];
}

- (IBAction)backAction:(id)sender
{
    self.navigationController.tabBarController.selectedIndex=0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
