//
//  ShouCangViewController.m
//  Store
//
//  Created by 杨小东 on 15/4/3.
//  Copyright (c) 2015年 mm. All rights reserved.
//

#import "ShouCangViewController.h"

@interface ShouCangViewController ()

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zuoFanHuiAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
