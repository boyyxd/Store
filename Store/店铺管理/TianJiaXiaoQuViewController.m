//
//  TianJiaXiaoQuViewController.m
//  Store
//
//  Created by wb on 15/2/11.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "TianJiaXiaoQuViewController.h"
#import "DianPuViewController.h"

@interface TianJiaXiaoQuViewController ()

@end

@implementation TianJiaXiaoQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.miaoShuTextView.layer.cornerRadius = 7;
    self.miaoShuTextView.layer.borderWidth = 1;
    self.miaoShuTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.miaoShuTextView.layer.masksToBounds = YES;

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

- (IBAction)zuoFanHuiAction:(id)sender
{
    DianPuViewController *dianPuVC = (DianPuViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:dianPuVC animated:YES];
}
@end
