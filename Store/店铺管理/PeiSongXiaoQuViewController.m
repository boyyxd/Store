//
//  PeiSongXiaoQuViewController.m
//  Store
//
//  Created by wb on 15/2/11.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "PeiSongXiaoQuViewController.h"
#import "TianJiaXiaoQuViewController.h"
#import "DianPuViewController.h"

@interface PeiSongXiaoQuViewController ()

@end

@implementation PeiSongXiaoQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    DianPuViewController *dianPuVC =(DianPuViewController *) [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:dianPuVC animated:YES];
}

- (IBAction)tianJiaXiaoQuAction:(id)sender
{
    TianJiaXiaoQuViewController *tianJiaVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tianjiaxiaoqu"];
    [self.navigationController pushViewController:tianJiaVC animated:YES];
}





@end
