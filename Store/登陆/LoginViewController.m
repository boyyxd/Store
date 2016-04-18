//
//  LoginViewController.m
//  Store
//
//  Created by mm on 15/1/23.
//  Copyright (c) 2015年 mm. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UrlFile.h"
#import "AFHTTPSessionManager.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import "CommonFunc.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "MyTabBarViewController.h"
#import "RootViewController.h"


@interface LoginViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loginViewSheZhi];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
}

- (void)loginViewSheZhi
{
    
    self.loginView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"5@2x.png"]];
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.passWordTextField.frame.size.width/290*50, self.passWordTextField.frame.size.height)];
    self.nameTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextfield.leftView = leftView1;
    
    UIView *leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.passWordTextField.frame.size.width/290*50, self.passWordTextField.frame.size.height)];
    self.passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTextField.leftView = leftView2;
    self.passWordTextField.secureTextEntry = YES;
    self.nameTextfield.delegate = self;
    self.passWordTextField.delegate = self;
    
}

#pragma mark --回收键盘--

- (IBAction)tapBackKeyBoard:(id)sender
{
    [self.nameTextfield resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
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

#pragma mark --登陆--

//MD5加密 32位小写
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}


- (IBAction)loginAction:(id)sender
{
    
    if ([self.nameTextfield.text isEqualToString:@""] || [self.passWordTextField.text isEqualToString:@""]) {
        self.nameTextfield.text = nil;
        self.passWordTextField.text = nil;
        UIAlertView *AV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码为空\n请重新输入..." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [AV show];
    }
    else{
        
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"登录中";
        [HUD  show:YES];

        NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextfield.text,@"storeLogin",self.passWordTextField.text,@"storePassWord",nil];
        NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",USER_LOGIN_URL,@"handler",nil];

        NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
        
        NSString * postStr = [postDic3 JSONString];
        
        NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
        
        NSLog(@"----------%@",postDic);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer.timeoutInterval = 15;//请求响应时间
        AFHTTPRequestSerializer * afSet = [[AFHTTPRequestSerializer alloc] init];
        afSet.timeoutInterval = 15;
        [manager setRequestSerializer:afSet];

        [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary * dataDic = (NSDictionary *)responseObject;
            NSLog(@"---------%@",dataDic);

            if ([[[dataDic objectForKey:@"paramObj"]objectForKey:@"success"]  isEqualToString: @"success"]) {
                NSLog(@"登录成功");
                HUD.labelText = @"登录成功";
                
                [HUD hide:YES afterDelay:2];
                NSDictionary * userDic = [[[dataDic objectForKey:@"paramObj"] objectForKey:@"storeList"] objectAtIndex:0] ;
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:userDic];
                
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userData"];
//                RootViewController * myVC = [[RootViewController alloc]init];
//                [self presentViewController:myVC animated:YES completion:nil];
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
                UIStoryboard *myStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                UIViewController *myVC = [myStory instantiateViewControllerWithIdentifier:@"myTB"];
                [self presentViewController:myVC animated:YES completion:nil];
//                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                HUD.labelText = @"用户名或密码错误";
                [HUD hide:YES afterDelay:1.5];
            }
            
           
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"网络连接失败";
            [HUD hide:YES afterDelay:2];
            
            NSLog(@"%@",error);

    
        }];

//        [manager POST:BASEURL parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            NSDictionary * resultDic = (NSDictionary *)responseObject;
//            NSLog(@"responseObject=%@",resultDic);
//        } failure:^(AFHTTPRequestOperation *task, NSError *error) {
//            NSLog(@"error=%@",error);
//        }];
//        
    }

}

#pragma mark --将焦点移至下一个文本--

- (IBAction)zhuCeAction:(id)sender {
    UIStoryboard *myStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myVC = [myStory instantiateViewControllerWithIdentifier:@"myTB"];
    [self presentViewController:myVC animated:YES completion:nil];
}

- (IBAction)nameTextField_DidEndOnExit:(id)sender
{
     // 将焦点移至下一个文本框.
    [self.passWordTextField becomeFirstResponder];
}

- (IBAction)passTextField_DidEndOnExit:(id)sender
{
     // 隐藏键盘.
    [sender resignFirstResponder];
    // 触发登陆按钮的点击事件.
    //[self.loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}


@end
