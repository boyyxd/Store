//
//  saoMaViewController.m
//  Store
//
//  Created by wb on 15/2/5.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "SaoMaViewController.h"

@interface SaoMaViewController ()

@end

@implementation SaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //self.navigationItem.leftBarButtonItem =
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)zuoFanHuiAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
