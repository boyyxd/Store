//
//  DianPuViewController.m
//  Store
//
//  Created by wb on 15/1/27.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "DianPuViewController.h"

@interface DianPuViewController ()

@end

@implementation DianPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
//    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"11(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"11.png"]];
    self.dianPuScrollView.contentSize = CGSizeMake(self.dianPuScrollView.frame.size.width, self.dianPuScrollView.frame.size.height * 1.3+20);
    
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
    self.navigationController.tabBarController.selectedIndex = 0;
}
@end
