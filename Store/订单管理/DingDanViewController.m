//
//  DingDanViewController.m
//  Store
//
//  Created by mm on 15/1/26.
//  Copyright (c) 2015年 mm. All rights reserved.
//

#import "DingDanViewController.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "JSONKit.h"
#import "UrlFile.h"
#import "MJRefresh.h"
#import "xinDingDanTableViewCell.h"
#import "shangPinTableViewCell.h"
#import "yiJieShouTableViewCell.h"
#import "shangPinXiaTableViewCell.h"



@interface DingDanViewController ()<MBProgressHUDDelegate>

{
    UIImageView *imageView; // 新订单等按钮选定下面的三角图片
    UIImageView *hongDianView; //新订单左上角的角标
    UILabel *numberLabel;//新订单角标的数字
    UIView *zheZhaoView;//遮罩层
    MBProgressHUD *HUD;//提示窗
    xinDingDanTableViewCell * cell1;//新订单的横划大Cell
    shangPinTableViewCell * cell2;//新订单里面的tableView的商品cell
    
    NSMutableArray * xddGoodListArray;//新订单商品数组
    NSMutableArray * xddOrderListArray;//新订单订单数组
    NSMutableArray * yjsGoodListArray;//已接受商品数组
    NSMutableArray * yjsOrderListArray;//已接受订单数组

}

@end

@implementation DingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollViewSheZhi];//设置最上面的scrollview
    [self hongDianSheZhi];//设置红点角标
    [self souSuoTextFieldSheZhi];//设置搜索框
    [self shangPinScrollViewSheZhi];// 主页面上的scrollview 适配4
    [self xinDingdanTableViewSheZhi];//新订单tableView
    [self yiSongDaScrollViewSheZhi];
    [self yiSongDaSheZhi];//已送达设置
    [self setsubViews];
    [self xinDingDanJieMianXiangQing];
    [self yiJieshouJieMian];
    
    
    //HUD提示窗
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.delegate = self;
    
    //新订单数组
    xddGoodListArray = [NSMutableArray array];
    xddGoodListArray = [NSMutableArray array];
    
    //已接受数组
    yjsGoodListArray = [NSMutableArray array];
    yjsOrderListArray = [NSMutableArray array];
    
    
    //商品tableView的设置
    self.chaXunView.layer.cornerRadius = 6;
    [self.yiJieShouView addHeaderWithTarget:self action:@selector(headerRereshing)];

    
}

- (void)headerRereshing
{
    [self yiJieshouJieMian];
}

-(void)xinDingdanTableViewSheZhi
{
    self.xinDingdanTableView.delegate = self;
    self.xinDingdanTableView.dataSource = self;
//    self.xinDingdanTableView.center = CGPointMake(self.view.frame.size.height / 2, self.view.frame.size.height / 2);
    //tableview逆时针旋转90度。
    self.xinDingdanTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
//    CGRect tableViewRect = CGRectMake(0.0, 0.0, 512.0, 414.0);
//    self.xinDingdanTableView.frame = tableViewRect;
    // scrollbar 不显示
    self.xinDingdanTableView.showsVerticalScrollIndicator = NO;
    self.xinDingdanTableView.pagingEnabled = YES;//tableView整夜滑动

}

#pragma mark ----------------------新订单页面数据---------------------------
//新订单数据获取

-(void)xinDingDanJieMianXiangQing{
    
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSString * storeCode = [userDic objectForKey:@"storecode"];
    NSString * storeID = [userDic objectForKey:@"storeid"];
    NSString * storeName = [userDic objectForKey:@"storename"];
//    NSLog(@"=======%@", userDic);
    NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:storeCode,@"storeCode",storeID,@"storeID",storeName,@"storename",@"1",@"orderType",nil];
//    NSLog(@"pt1=======%@", postDic1);
    NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",NEWORDER_URL,@"handler",@"1",@"isLogin",nil];
    
    NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
    
    NSString * postStr = [postDic3 JSONString];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
    
    NSLog(@"postDic----------新订单%@",postDic);
    
//    NSLog(@"postDic----------%@",postDic);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * resonseObjectDic = (NSDictionary *)responseObject;
//        NSLog(@"resonseObjectDic----------%@",resonseObjectDic);
        
        NSLog(@"resonseObjectDic----------新订单%@",resonseObjectDic);
        
        xddGoodListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"goodList"];
        
        NSLog(@"xddGoodListArray===%@商品11----------",xddGoodListArray);
        
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:xddGoodListArray];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"xddGoodList"];
        
        //------------------------------------
        xddOrderListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"orderList"];
        
        NSLog(@"xddOrderListArray===%@商品22----------",xddOrderListArray);
        
        NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:xddOrderListArray];
        
        [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"xddOrderList"];
        
        if (resonseObjectDic != nil) {
            [self.yiJieShouView headerEndRefreshing];
            [HUD  show:YES];
            HUD.labelText = @"加载成功";
            HUD.mode = MBProgressHUDModeText;
            [HUD hide:YES afterDelay:1];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error=%@",error);
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:2];
    }];


}


#pragma mark ----------------------已接受页面数据---------------------------
//已接受数据获取

- (void)yiJieshouJieMian{
    [self.yiJieShouView addSubview:HUD];
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSString * storeCode = [userDic objectForKey:@"storecode"];
    NSString * storeID = [userDic objectForKey:@"storeid"];
    NSString * storeName = [userDic objectForKey:@"storename"];
    //    NSLog(@"=======%@", userDic);
    NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:storeCode,@"storeCode",storeID,@"storeID",storeName,@"storename",nil];
    //    NSLog(@"pt1=======%@", postDic1);
    NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",CONDUCT_ORDER_URL,@"handler",@"1",@"isLogin",nil];
    
    NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
    
    NSString * postStr = [postDic3 JSONString];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
    
    //    NSLog(@"postDic----------%@",postDic);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * resonseObjectDic = (NSDictionary *)responseObject;
        
//        NSLog(@"resonseObjectDic----------新订单%@",resonseObjectDic);
        
        yjsGoodListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"goodList"];
        
//        NSLog(@"yjsGoodListArray===%@商品11----------",yjsGoodListArray);
        
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:yjsGoodListArray];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"yjsGoodList"];
        
        //------------------------------------
        yjsOrderListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"orderList"];
        
//        NSLog(@"yjsOrderListArray===%@商品22----------",yjsOrderListArray);
        
        NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:yjsOrderListArray];
        
        [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"yjsOrderList"];
        if (resonseObjectDic != nil) {
            [self.yiJieShouView headerEndRefreshing];
            [HUD  show:YES];
            HUD.labelText = @"加载成功";
            HUD.mode = MBProgressHUDModeText;
            [HUD hide:YES afterDelay:1];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error=%@",error);
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:2];
    }];

    
}


#pragma mark ----------------------已完成页面数据---------------------------
//已完成界面数据获取
- (void)yiWanChengJieMian{
    
}

-(void)setsubViews
{
  //  self.chongZhiButton.layer.cornerRadius = 5;
}

- (void) hongDianSheZhi
{
    hongDianView = [[UIImageView alloc]initWithFrame:CGRectMake(78, 5, 18 , 18)];
    hongDianView.image = [UIImage imageNamed:@"14.png"];
    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 18 , 18)];
    numberLabel.font = [UIFont fontWithName:@"Arial" size:11];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"9";
    numberLabel.textColor = [UIColor whiteColor];
    [hongDianView addSubview:numberLabel];
    // label 变化 则 显示新订单条数
    [self.xinDingDanButton addSubview:hongDianView];
    
}

- (void) scrollViewSheZhi
{
    //button被选中图片
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 41, 100, 9)];
    imageView.image = [UIImage imageNamed:@"17.png"];
    
    self.caiDanScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 45);
    self.caiDanScrollView.delaysContentTouches = NO;
    
    if (self.xinDingDanButton.selected == NO) {
        [self.xinDingDanButton addTarget:self action:@selector(xinDingDanAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.yiJieShouButton.selected == NO) {
        [self.yiJieShouButton addTarget:self action:@selector(yiJieshouAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.yiWanChengButton.selected == NO) {
        [self.yiWanChengButton addTarget:self action:@selector(yiWanChengAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.liShiButton.selected == NO) {
        [self.liShiButton addTarget:self action:@selector(liShiAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (void) souSuoTextFieldSheZhi
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

- (void)shangPinScrollViewSheZhi
{

//    self.shangPinTableView.delaysContentTouches = NO;
//    self.shangPinTableView.contentSize = CGSizeMake(self.shangPinTableView.frame.size.width, self.shangPinTableView.frame.size.height+10);
//    
//    self.shangPinTableView.delegate = self;
//    
//    // tableView 设置背景框
////    UIImageView * tableImageView = [[UIImageView alloc]initWithFrame:self.shangPinTableView.frame];
////    tableImageView.image = [UIImage imageNamed:@"18.png"];
////    [self.shangPinTableView setBackgroundView:tableImageView];
//    self.shangPinTableView.delegate = self;
//    self.shangPinTableView.dataSource = self;
    
}

- (void)yiSongDaScrollViewSheZhi
{
    
    self.yiJieShouView.delaysContentTouches = NO;
    self.yiJieShouView.contentSize = CGSizeMake(self.yiJieShouView.frame.size.width, self.yiJieShouView.frame.size.height * 1.4 + 15);
    self.yiJieShouView.delegate = self;
    self.yiJieShouTableView.delegate = self;
    self.yiJieShouTableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.xinDingdanTableView) {
        return 1;
    }
    else
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.xinDingdanTableView) {
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"xddOrderList"];
        
        NSMutableArray * orderList = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成数组
        NSLog(@"@@%ld",orderList.count);

        return orderList.count;
    }

    if (tableView == self.yiJieShouTableView && section == 0) {
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"yjsOrderList"];
        
        NSMutableArray * yjsOrderList = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成数组
        NSMutableArray * array = [yjsOrderList objectAtIndex:0];
        return array.count;
    }
    if (section == 1) {
        return 3;
    }
    else
        return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.xinDingdanTableView) {
        static NSString * cellid = @"xinDingDanTableViewCell";
        
        cell1 = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        cell1.xddScrollView.contentSize = CGSizeMake(cell1.xddScrollView.frame.size.width, cell1.xddScrollView.frame.size.height+5);
        cell1.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);

        //创建新订单横划的大cell
//        if (!cell1)
//        {
//
//            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell1 = [[xinDingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//            cell1.shangPinTableView = [story instantiateViewControllerWithIdentifier:@"myTB"];
//            cell1.shangPinTableView.tag = indexPath.row;
//            NSLog(@"-----========++++++++++++%ld",(long)cell1.shangPinTableView.tag);
//            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//        }

        cell1.shangPinTableView.tag = indexPath.row;
        cell1.tag = indexPath.row;
        NSLog(@"-----========++++++++++++%ld",(long)cell1.shangPinTableView.tag);
        NSLog(@"=++++++++++++%ld",(long)cell1.tag);

        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell1.shangPinTableView.backgroundColor = [UIColor purpleColor ];

        return cell1;
    }
    
    if (tableView == cell1.shangPinTableView) {
        NSLog(@"12312");
        static NSString * shangPinCell = @"shangPinTableViewCell";
        
        cell2 = [tableView dequeueReusableCellWithIdentifier:shangPinCell];
        if (!cell2) {
            cell2 = [[shangPinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shangPinCell];
        }
        cell2.shangPinName.text = @"aaa";
        
        return cell2;
    }
    if (tableView == self.yiJieShouTableView && indexPath.section == 0) {
        
        static NSString * shangPinXiaCell = @"cell";
        
        yiJieShouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shangPinXiaCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"yiJieShouTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"yjsGoodList"];
        
        NSMutableArray * goodList = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成数组
        
        NSDictionary *dic = [[goodList objectAtIndex:0] objectAtIndex:0];
        
        cell.shangPinName.text = [[dic objectForKey:@"goodsName"] description];
        cell.shangPinNumber.text = [[dic objectForKey:@"goodsCount"] description];
        cell.shangPinPrice.text = [[dic objectForKey:@"price"] description];
        return cell;
    }
    if (tableView == self.yiJieShouTableView && indexPath.section == 1) {
        static NSString * shangPinXiaCell = @"cell";
        
        shangPinXiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shangPinXiaCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"shangPinXiaTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"yjsOrderList"];
        
        NSMutableArray * orderList = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成数组
        
        NSDictionary *dic = [orderList objectAtIndex:0];
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"合计金额";
            cell.valueLabel.text = [[dic objectForKey:@"totalPrice"] description];
            cell.contentView.backgroundColor = [UIColor greenColor];
            
        }
        if (indexPath.row == 1) {
            cell.nameLabel.text = @"配送地址";
            cell.valueLabel.text = [[dic objectForKey:@"detailedAddress"] description];
            cell.contentView.backgroundColor = [UIColor yellowColor];
            
        }
        if (indexPath.row == 2) {
            cell.nameLabel.text = @"联系电话(可直接拨打)";
            cell.valueLabel.text = [[dic objectForKey:@"mobileNo"] description];
            cell.contentView.backgroundColor = [UIColor cyanColor];
            
        }
        return cell;

    }
    else{
    static NSString * cellid = @"cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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


//点击返回
- (IBAction)backAction:(id)sender
{
    self.tabBarController.selectedIndex = 0;
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [zheZhaoView removeFromSuperview];
    self.chaXunView.hidden = YES;
    self.shaiXuanButton.selected = NO;
}

- (IBAction)dingDanHaoHuiShouAction:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}

- (IBAction)shouHuoRenHuiShouAction:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}

- (IBAction)dingDanShiJianHuiShouAction:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}

- (IBAction)dingDanZongJiaMinHuiShouAction:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}

- (IBAction)dingDanZongJiaMaxHuiShouAction:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
}


- (IBAction)chongZhiAction:(id)sender
{
    self.dingDanHaoTextField.text = nil;
    self.shouHuoRenTextField.text = nil;
    self.shouHuoShiJianTextField.text = nil;
    self.dingDanZongJiaMaxTextField.text = nil;
    self.dingDanZongJiaMinTextField.text = nil;
}

- (IBAction)queDIngAction:(id)sender
{
    [zheZhaoView removeFromSuperview];
    self.chaXunView.hidden = YES;
    self.shaiXuanButton.selected = NO;
}

- (IBAction)tapHuiShouJianPan:(id)sender
{
    [self.souSuoTextField resignFirstResponder];
//    self.buJieShouView.hidden = YES;
//    self.buJieShouButton.selected = NO;
    self.dingDanZhuangTaiView.hidden = YES;
    self.dingDanZhuangTaiButton.selected = NO;
}


- (IBAction)shaiXuanAction:(id)sender
{
    if (self.shaiXuanButton.selected == NO)
    {
        self.shaiXuanButton.selected = YES;
        zheZhaoView = [[UIView alloc]init];
        zheZhaoView.frame = [[UIScreen mainScreen]  bounds];
        zheZhaoView.backgroundColor = [UIColor grayColor];
        zheZhaoView.alpha = 0.8;
        [self.view addSubview:zheZhaoView];
        
        self.chaXunView.backgroundColor = [UIColor whiteColor];
        self.chaXunView.hidden = NO;
        [self.view addSubview:self.chaXunView];
    }
    else
    {
        [zheZhaoView removeFromSuperview];
        self.chaXunView.hidden = YES;
        self.shaiXuanButton.selected = NO;
    }
    
    
}

- (IBAction)huiShouJianPan:(id)sender
{
    [self resignFirstResponder];
//    self.buJieShouView.hidden = YES;
}

//新订单button
- (IBAction)xinDingDanAction:(id)sender
{
    self.xinDingdanTableView.hidden = NO;
    self.yiJieShouView.hidden = YES;
//    self.shangPinTableView.hidden = NO;
//    self.jieShouButton.hidden = NO;
//    self.buJieShouButton.hidden = NO;
//    self.buJieShouView.hidden = YES;
    self.yiWanChengView.hidden = YES;
    self.liShiDingDanView.hidden = YES;
    
    self.yiJieShouButton.selected = NO;
    self.yiWanChengButton.selected = NO;
//    self.buJieShouButton.selected = NO;
    self.liShiButton.selected = NO;
    self.dingDanZhuangTaiView.hidden = YES;
    self.dingDanZhuangTaiButton.selected = NO;
    
    self.xinDingDanButton.selected = YES;
    
    
//    self.shangPinTableView.contentSize = CGSizeMake(self.shangPinTableView.frame.size.width, self.shangPinTableView.frame.size.height+10);
    
    //点击变蓝
    self.xinDingDanButton.tintColor = [UIColor clearColor];
    [self.xinDingDanButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:UIControlStateSelected];
    
    //点击前移除状态图
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 100, 9);
    //点击添加状态图
    [self.xinDingDanButton addSubview:imageView];
//    [hongDianView removeFromSuperview];
    
    
}

//已接受button
- (IBAction)yiJieshouAction:(id)sender
{
//    [self quanBuYinCang];
    self.xinDingdanTableView.hidden = YES;

    self.yiJieShouView.hidden = NO;
//    self.shangPinTableView.hidden = YES;
    self.xinDingDanButton.selected = NO;
    self.yiWanChengButton.selected = NO;
//    self.buJieShouView.hidden = YES;
    self.liShiButton.selected = NO;
//    self.jieShouButton.hidden = YES;
//    self.buJieShouButton.hidden = YES;
    self.yiWanChengView.hidden = YES;
    self.liShiDingDanView.hidden = YES;
    self.dingDanZhuangTaiView.hidden = YES;
    self.dingDanZhuangTaiButton.selected = NO;

    
    self.yiJieShouButton.selected = YES;
    
//    self.shangPinTableView.contentSize = CGSizeMake(self.shangPinTableView.frame.size.width, self.shangPinTableView.frame.size.height*1.5);
    
    self.yiJieShouButton.tintColor = [UIColor clearColor];
    [self.yiJieShouButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:UIControlStateSelected];
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 100, 9);
    [self.yiJieShouButton addSubview:imageView];
}

//已完成button
- (IBAction)yiWanChengAction:(id)sender
{
//    [self quanBuYinCang];
    self.xinDingdanTableView.hidden = YES;

    self.yiJieShouView.hidden = YES;
//    self.shangPinTableView.hidden = YES;
    self.xinDingDanButton.selected = NO;
    self.yiJieShouButton.selected = NO;
    self.liShiButton.selected = NO;
    self.yiWanChengView.hidden = NO;
    self.liShiDingDanView.hidden = YES;
    self.dingDanZhuangTaiView.hidden = YES;
    self.dingDanZhuangTaiButton.selected = NO;
    
    self.yiWanChengButton.selected = YES;
    self.yiWanChengButton.tintColor = [UIColor clearColor];
    [self.yiWanChengButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:UIControlStateSelected];
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 100, 9);
    [self.yiWanChengButton addSubview:imageView];
    
    
    
}

//历史订单查询button
- (IBAction)liShiAction:(id)sender
{
//    [self quanBuYinCang];
    self.xinDingdanTableView.hidden = YES;

    self.xinDingDanButton.selected = NO;
    self.yiJieShouButton.selected = NO;
    self.yiWanChengButton.selected = NO;
    
    self.yiJieShouView.hidden = YES;
//    self.shangPinTableView.hidden = YES;
    self.yiWanChengView.hidden = YES;
    self.liShiDingDanView.hidden = NO;
    
    self.liShiButton.selected = YES;
    self.liShiButton.tintColor = [UIColor clearColor];
    [self.liShiButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 114, 9);
    [self.liShiButton addSubview:imageView];
    

    
}

//订单状态Action
- (IBAction)dingDanZhuangTaiAction:(id)sender {
    if (self.dingDanZhuangTaiButton.selected == NO) {
    self.dingDanZhuangTaiButton.selected = YES;
    self.dingDanZhuangTaiButton.tintColor = [UIColor clearColor];
    [self.dingDanZhuangTaiButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    
        self.dingDanZhuangTaiView.hidden = NO;
    }else{
        self.dingDanZhuangTaiButton.selected = NO;
        self.dingDanZhuangTaiView.hidden = YES;
    }
    
    
}

- (IBAction)yiWanCheng2Action:(id)sender
{
    self.yiWanCheng2Button.selected = YES;
    self.weiJieDan2Button.selected = NO;
    self.weiWanCheng2Button.selected = NO;
    
    self.yiWanCheng2Button.tintColor = [UIColor clearColor];
    [self.yiWanCheng2Button setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    [self.yiWanCheng2Button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}

- (IBAction)weiJieDan2Action:(id)sender
{
    self.weiJieDan2Button.selected = YES;
    self.yiWanCheng2Button.selected = NO;
    self.weiWanCheng2Button.selected = NO;
    
    self.weiJieDan2Button.tintColor = [UIColor clearColor];
    [self.weiJieDan2Button setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    [self.weiJieDan2Button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}

- (IBAction)weiWanCheng2Action:(id)sender
{
    self.weiWanCheng2Button.selected = YES;
    self.yiWanCheng2Button.selected = NO;
    self.weiJieDan2Button.selected = NO;
    
    self.weiWanCheng2Button.tintColor = [UIColor clearColor];
    [self.weiWanCheng2Button setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    [self.weiWanCheng2Button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}

-(void)yiSongDaSheZhi
{
    self.yiSongDaButton.layer.cornerRadius = 5.0;
//    // tableView 设置背景框
//    UIImageView * tableImageView = [[UIImageView alloc]initWithFrame:self.yiSongDaTableView.frame];
//    tableImageView.image = [UIImage imageNamed:@"18.png"];
//    [self.yiSongDaTableView setBackgroundView:tableImageView];
    
    self.yiSongDaTableView.delegate = self;
    self.yiSongDaTableView.dataSource = self;

}

- (void)quanBuYinCang
{
//    self.buJieShouView.hidden = YES;
//    self.buJieShouButton.hidden = YES;
//    self.jieShouButton.hidden = YES;
    
}

//- (IBAction)buJieShouAction:(id)sender//不接受按钮
//{
//    if (self.buJieShouView.hidden == YES) {
//        self.buJieShouView.hidden = NO;
//        self.buJieShouButton.selected = YES;
//        [self.buJieShouButton setBackgroundImage:[UIImage imageNamed:@"22(1).png"] forState:UIControlStateSelected ];
//        [self.buJieShouButton setImage:[UIImage imageNamed:@"26.png"] forState:UIControlStateSelected];
//    }else{
//        self.buJieShouView.hidden = YES;
//        self.buJieShouButton.selected = NO;
//    }
//
//}
//
//
//
//- (IBAction)jieShouAction:(id)sender//接受按钮
//{
//    self.buJieShouView.hidden = YES;
//    self.buJieShouButton.selected = NO;
//    [self.jieShouButton setBackgroundImage:[UIImage imageNamed:@"21(1).png"] forState:UIControlStateDisabled ];
//}
//
//
//- (IBAction)meiShiJianAction:(id)sender//没时间
//{
//    self.meiShiJianButton.selected = YES;
//
//    self.shangPinBuZuButton.selected = NO;
//    self.buZaiFanWeiButton.selected = NO;
//    self.othersButton.selected = NO;
//
//    self.meiShiJianButton.tintColor = [UIColor clearColor];
//
//
//    [self.meiShiJianButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
//    [self.meiShiJianButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
//}
//
//- (IBAction)shangPinBuZuAction:(id)sender//商品不足
//{
//    self.shangPinBuZuButton.selected = YES;
//
//    self.meiShiJianButton.selected = NO;
//    self.buZaiFanWeiButton.selected = NO;
//    self.othersButton.selected = NO;
//
//    self.shangPinBuZuButton.tintColor = [UIColor clearColor];
//    [self.shangPinBuZuButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
//    [self.shangPinBuZuButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
//}
//
//- (IBAction)buZaiFanWeiAction:(id)sender
//{
//    self.buZaiFanWeiButton.selected = YES;
//
//    self.meiShiJianButton.selected = NO;
//    self.shangPinBuZuButton.selected = NO;
//    self.othersButton.selected = NO;
//
//    self.buZaiFanWeiButton.tintColor = [UIColor clearColor];
//    [self.buZaiFanWeiButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
//    [self.buZaiFanWeiButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
//}
//
//- (IBAction)othersAction:(id)sender
//{
//    self.othersButton.selected = YES;
//
//    self.meiShiJianButton.selected = NO;
//    self.buZaiFanWeiButton.selected = NO;
//    self.shangPinBuZuButton.selected = NO;
//
//    self.othersButton.tintColor = [UIColor clearColor];
//    [self.othersButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
//    [self.othersButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
//}

@end
