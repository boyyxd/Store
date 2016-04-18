

#import "RootViewController.h"
#import "DingDanViewController.h"
#import "ZJSwitch.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "JSONKit.h"
#import "UrlFile.h"


@interface RootViewController ()<MBProgressHUDDelegate>
{
    UILabel *onLabel;
    ZJSwitch *switch0;
    UIAlertView *alertView1;
    UIAlertView *alertView2;
    MBProgressHUD *HUD;
}
@end

@implementation RootViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self switchSheZhi];
    alertView1.tag = 1000;
    alertView2.tag = 1001;
    alertView1.delegate = self;
    alertView2.delegate = self;
    alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"进入停业状态" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"停业", nil];
    
    alertView2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"进入营业状态..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"营业", nil];

    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
}

#pragma mark --switch开关设置--

- (void)switchSheZhi
{
    switch0 = [[ZJSwitch alloc]init];
    switch0.frame = CGRectMake(0, 0, 61, 20);
    switch0.on = YES;
    switch0.backgroundColor = [UIColor clearColor];
    switch0.tintColor = [UIColor orangeColor];
    switch0.onText = @"营业";
    switch0.offText = @"停业";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:switch0];
    self.navigationItem.rightBarButtonItem = rightItem;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwitchEvent1:)];
//    tap.delegate = self;
//    [switch0 addGestureRecognizer:tap];
    
    [switch0 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    

//    CGRect rect = self.yingYeSwitch.frame;
//    rect = CGRectMake(0, 0, 100, self.yingYeSwitch.frame.size.height);
//    self.yingYeSwitch.frame = rect;
//    self.yingYeSwitch.layer.borderWidth = 1;
//    self.yingYeSwitch.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.yingYeSwitch.layer.cornerRadius = 15;
//    
//    onLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 25, 20)];
//    onLabel.text = @"营业";
//    onLabel.font = [UIFont fontWithName:nil size:10];
//    [self.yingYeSwitch addSubview:onLabel];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == alertView1 && buttonIndex == 0)//停业按钮
    {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"提示：取消不进行任何操作";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
    if (alertView == alertView2 && buttonIndex == 0)//停业按钮
    {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"提示：取消不进行任何操作";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
    if (alertView == alertView1 && buttonIndex == 1)//停业按钮
    {
        switch0.on = NO;
        
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"店铺关闭中...";
        [HUD  show:YES];
        
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
        NSLog(@"%@",data);
        
        NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
        NSString * storeCode = [userDic objectForKey:@"storecode"];
        NSString * storeID = [userDic objectForKey:@"storeid"];
        NSString * userName = [userDic objectForKey:@"username"];
        NSString * userId = [userDic objectForKey:@"userid"];
        NSLog(@"=======%@", userDic);
        NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:storeCode,@"storeCode",storeID,@"storeID",userName,@"userName",userId,@"userId",@"0",@"isWork",nil];
        NSLog(@"pt1=======%@", postDic1);
        NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",STOREOPEN_URL,@"handler",@"1",@"isLogin",nil];
        
        NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
        
        NSString * postStr = [postDic3 JSONString];
        
        NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
        
        NSLog(@"postDic----------%@",postDic);
        
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 15;
        [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary * resonseObjectDic = (NSDictionary *)responseObject;
            NSLog(@"resonseObjectDic----------%@",resonseObjectDic);
            if ([[[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"msg"]isEqualToString:@"修改成功"]) {
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = @"停业成功";
                
                [HUD hide:YES afterDelay:2];
            
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error=%@",error);
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"网络连接失败";
            [HUD hide:YES afterDelay:2];
        }];

        
    }
    if (alertView == alertView2 && buttonIndex == 1)//营业按钮
    {
        switch0.on = YES;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"店铺开启中...";
        [HUD  show:YES];
        
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
        NSLog(@"%@",data);
//        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        NSDictionary* userDic = [unarchiver decodeObjectForKey:@"userData"];
//        [unarchiver finishDecoding];
        NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
        NSString * storeCode = [userDic objectForKey:@"storecode"];
        NSString * storeID = [userDic objectForKey:@"storeid"];
        NSString * userName = [userDic objectForKey:@"username"];
        NSString * userId = [userDic objectForKey:@"userid"];
        NSLog(@"=======%@", userDic);
        NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:storeCode,@"storeCode",storeID,@"storeID",userName,@"userName",userId,@"userId",@"1",@"isWork",nil];
        NSLog(@"pt1=======%@", postDic1);
        NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",STOREOPEN_URL,@"handler",@"1",@"isLogin",nil];
        
        NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
        
        NSString * postStr = [postDic3 JSONString];
        
        NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
        
        NSLog(@"postDic----------%@",postDic);
        
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 15;
        [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary * resonseObjectDic = (NSDictionary *)responseObject;
            NSLog(@"resonseObjectDic----------%@",resonseObjectDic);
            if ([[[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"msg"]isEqualToString:@"修改成功"]) {
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = @"开店成功";
                [HUD hide:YES afterDelay:2];

            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error=%@",error);
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"网络连接失败";
            [HUD hide:YES afterDelay:2];
        }];
        

    }
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

#pragma mark --新订单方法--

- (IBAction)xinDingDan:(id)sender
{
//    DingDanViewController *dingDanVC;
//    dingDanVC = [self.navigationController.tabBarController.viewControllers objectAtIndex:1];
//
    
//    UINavigationController * dingDanNC = [self.tabBarController.viewControllers objectAtIndex:1];
//    
//    DingDanViewController * dingDanVC = [dingDanNC.viewControllers objectAtIndex:0];
//    
//
//    [self.navigationController pushViewController:dingDanVC animated:YES];
    self.tabBarController.selectedIndex = 1;
    
//    DingDanViewController *dingDanVC = [DingDanViewController new];
//    self.navigationController.tabBarController.selectedIndex = 1;
////
//    [dingDanVC performSelector:@selector(xinDingDanAction:) withObject:nil];
 

}

#pragma mark --switch开关方法--


- (void)handleSwitchEvent:(id)sender {
//   UISwitch *switch1 = (UISwitch *)sender;
//    BOOL switchIsOn = [switch1 isOn];
    
    if (switch0.on == NO) {
        [alertView1 show];
    }
    else{
        
        [alertView2 show];
    }
}

@end
