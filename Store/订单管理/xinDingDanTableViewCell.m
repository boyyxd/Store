//
//  xinDingDanTableViewCell.m
//  Store
//
//  Created by 杨小东 on 15/4/10.
//  Copyright (c) 2015年 王博. All rights reserved.
//

#import "xinDingDanTableViewCell.h"
#import "shangPinTableViewCell.h"
#import "shangPinXiaTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "UrlFile.h"
#import "JSONKit.h"
#import "MJRefresh.h"

@implementation xinDingDanTableViewCell
{
    MBProgressHUD * HUD;
    NSMutableArray * goodListArray;
    NSMutableArray * orderListArray;
    NSTimer *timer;
}
- (void)awakeFromNib {
    // Initialization code
    self.shangPinTableView.delegate = self;
    self.shangPinTableView.dataSource = self;
    //HUD提示窗
    HUD = [[MBProgressHUD alloc]initWithView:self];
    HUD.delegate = self;
    [self.contentView addSubview:HUD];
    
    goodListArray = [NSMutableArray array];
    orderListArray = [NSMutableArray array];
    [self getdata];
    [self.xddScrollView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.shangPinTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    

    
}
- (void)footerRereshing{
    
}
- (void)headerRereshing{
    [self getdata];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (IBAction)buJieShouAction:(id)sender//不接受按钮
{
    if (self.buJieShouView.hidden == YES) {
        self.buJieShouView.hidden = NO;
        self.buJieShouButton.selected = YES;
        [self.buJieShouButton setBackgroundImage:[UIImage imageNamed:@"22(1).png"] forState:UIControlStateSelected ];
        [self.buJieShouButton setImage:[UIImage imageNamed:@"26.png"] forState:UIControlStateSelected];
    }else{
        self.buJieShouView.hidden = YES;
        self.buJieShouButton.selected = NO;
    }
    
}



- (IBAction)jieShouAction:(id)sender//接受按钮
{
    self.buJieShouView.hidden = YES;
    self.buJieShouButton.selected = NO;
    [self.jieShouButton setBackgroundImage:[UIImage imageNamed:@"21(1).png"] forState:UIControlStateDisabled ];
}


- (IBAction)meiShiJianAction:(id)sender//没时间
{
    self.meiShiJianButton.selected = YES;
    self.shangPinBuZuButton.selected = NO;
    self.buZaiFanWeiButton.selected = NO;
    self.othersButton.selected = NO;
    
    self.meiShiJianButton.tintColor = [UIColor clearColor];
    
    
    [self.meiShiJianButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    [self.meiShiJianButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.buJieShouView.alpha = 0;
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
}

- (IBAction)shangPinBuZuAction:(id)sender//商品不足
{
    self.shangPinBuZuButton.selected = YES;
    self.meiShiJianButton.selected = NO;
    self.buZaiFanWeiButton.selected = NO;
    self.othersButton.selected = NO;
    
    self.shangPinBuZuButton.tintColor = [UIColor clearColor];
    [self.shangPinBuZuButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    [self.shangPinBuZuButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.buJieShouView.alpha = 0;
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
}

- (IBAction)buZaiFanWeiAction:(id)sender
{
    self.buZaiFanWeiButton.selected = YES;
    self.meiShiJianButton.selected = NO;
    self.shangPinBuZuButton.selected = NO;
    self.othersButton.selected = NO;
    
    self.buZaiFanWeiButton.tintColor = [UIColor clearColor];
    [self.buZaiFanWeiButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    [self.buZaiFanWeiButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.buJieShouView.alpha = 0;
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
}

- (IBAction)othersAction:(id)sender
{
    self.othersButton.selected = YES;
    self.meiShiJianButton.selected = NO;
    self.buZaiFanWeiButton.selected = NO;
    self.shangPinBuZuButton.selected = NO;
    
    self.othersButton.tintColor = [UIColor clearColor];
    [self.othersButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0]forState:UIControlStateSelected];
    [self.othersButton setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.buJieShouView.alpha = 0;
    [UIView commitAnimations];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
}

- (void)c{

    self.buJieShouView.hidden = YES;
    self.buJieShouView.alpha = 1;
    self.buJieShouButton.selected = NO;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"goodList"];
    NSMutableArray * goodList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (section == 0) {
        NSMutableArray *array = [goodList objectAtIndex:tableView.tag];
        
        return array.count;
    }
    if (section == 1) {
        return 3;
    }
    return 0;

}

- (void)getdata
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSString * storeCode = [userDic objectForKey:@"storecode"];
    NSString * storeID = [userDic objectForKey:@"storeid"];
    NSString * storeName = [userDic objectForKey:@"storename"];
    
    NSLog(@"=======%@新订单", userDic);
    NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:storeCode,@"storeCode",storeID,@"storeID",storeName,@"storename",@"1",@"orderType",nil];
    NSLog(@"pt1=======新订单%@", postDic1);
    NSDictionary *postDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"connectType",NEWORDER_URL,@"handler",@"1",@"isLogin",nil];
    
    NSDictionary *postDic3 = [NSDictionary dictionaryWithObjectsAndKeys:postDic1,@"paramObj",postDic2,@"requester",nil];
    
    NSString * postStr = [postDic3 JSONString];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
    
    NSLog(@"postDic----------新订单%@",postDic);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:BASEURL parameters:postDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * resonseObjectDic = (NSDictionary *)responseObject;
        if (resonseObjectDic != nil) {
            [self.xddScrollView headerEndRefreshing];
            [HUD  show:YES];

            HUD.labelText = @"加载成功";
            HUD.mode = MBProgressHUDModeText;
            [HUD hide:YES afterDelay:1];
        }
        
        //------------------------------------
        NSLog(@"resonseObjectDic----------新订单%@",resonseObjectDic);
        goodListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"goodList"];
        NSLog(@"%@商品11----------",goodListArray);
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:goodListArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"goodList"];
        
        //------------------------------------
        orderListArray = [[resonseObjectDic objectForKey:@"paramObj"]objectForKey:@"orderList"];
        NSLog(@"%@商品22----------",orderListArray);
        NSData * data1 = [NSKeyedArchiver archivedDataWithRootObject:orderListArray];
        [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"orderList"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error=%@",error);
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:2];
    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (/*self.shangPinTableView.tag == indexPath.row && */indexPath.section == 0) {
        static NSString * shangPinCell = @"shangPinTableViewCell";
        
        shangPinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shangPinCell];
//        if (!cell) {
//            cell = [[shangPinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shangPinCell];
//        }
        
        NSData * data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"goodList"];
        
        NSMutableArray * goodList = [NSKeyedUnarchiver unarchiveObjectWithData:data1];//data文件转成数组
        NSLog(@"iiiii%ld",tableView.tag);
        NSLog(@"jjjjj%ld",self.shangPinTableView.tag);
        NSMutableDictionary *dic = [[goodList objectAtIndex:tableView.tag]objectAtIndex:indexPath.row];
        NSLog(@"dic=%@",goodList);
        NSString * dingDanNumber = [[dic objectForKey:@"orderNo"]description];
        NSString * goodsName = [[dic objectForKey:@"goodsName"] description];
        NSString * goodsCount = [[dic objectForKey:@"goodsCount"] description];
        NSString * price = [[dic objectForKey:@"price"] description];
        
        self.dingDanNumberLabel.text = dingDanNumber;
        cell.shangPinName.text = goodsName;
        cell.shangPinNumber.text = goodsCount;
        cell.shangPinPrice.text = price;
        return cell;
    }
    if (/*self.shangPinTableView.tag == indexPath.row &&*/indexPath.section == 1) {
        static NSString * shangPinXiaCell = @"cell";
        
        shangPinXiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shangPinXiaCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"shangPinXiaTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderList"];
        
        NSMutableArray * orderList = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成数组
        
        NSDictionary *dic = [orderList objectAtIndex:self.tag];
        

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
    else
        return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



@end
