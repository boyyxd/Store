//
//  ShangPinViewController.m
//  Store
//
//  Created by wb on 15/1/27.
//  Copyright (c) 2015年 wb. All rights reserved.
//

#import "ShangPinViewController.h"

@interface ShangPinViewController ()
{
    UIImageView * imageView;
}
@end

@implementation ShangPinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    [self souSuoTextFieldSheZhi];
    
}

-(void)setupSubViews
{
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 41, 103, 9 );
    imageView.image = [UIImage imageNamed:@"17.png"];
}

-(void)souSuoTextFieldSheZhi
{
    UIView *leftView =[[UIView alloc]init];
    leftView.frame = CGRectMake(0, 0, 30, self.souSuoTextField.frame.size.height);
    
    UIButton * rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    rightButton.frame = CGRectMake(0, 0, 70, self.souSuoTextField.frame.size.height);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"15.png"] forState:(UIControlStateNormal)];
    
    self.souSuoTextField.leftView = leftView;
    self.souSuoTextField.leftViewMode = UITextFieldViewModeAlways;
    self.souSuoTextField.rightView = rightButton;
    self.souSuoTextField.rightViewMode = UITextFieldViewModeAlways;
    self.souSuoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)yiShangJiaAction:(id)sender
{
    self.diKuCunView.hidden = YES;
    self.shangPinKuView.hidden = YES;
    self.tianJiaView.hidden = YES;
    self.yiShangJiaView.hidden = NO;
    
    self.diKuCunButton.selected = NO;
    self.shangPinKuButton.selected = NO;
    self.tianJiaShangPinButton.selected = NO;
    
    self.yiShangJiaButton.selected = YES;
    self.tianJiaShangPinView.hidden = YES;
    
    self.yiShangJiaButton.tintColor = [UIColor clearColor];
    [self.yiShangJiaButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 103, 9);
    
    [self.yiShangJiaButton addSubview:imageView];
    
}

- (IBAction)diKuCunAction:(id)sender
{
    self.yiShangJiaView.hidden = YES;
    self.shangPinKuView.hidden = YES;
    self.tianJiaView.hidden = YES;
    self.diKuCunView.hidden = NO;
    
    self.yiShangJiaButton.selected = NO;
    self.shangPinKuButton.selected = NO;
    self.tianJiaShangPinButton.selected = NO;
    
    self.diKuCunButton.selected = YES;
    self.tianJiaShangPinView.hidden = YES;
    
    self.diKuCunButton.tintColor = [UIColor clearColor];
    [self.diKuCunButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 103, 9);
    
    [self.diKuCunButton addSubview:imageView];
}

- (IBAction)shangPinKuAction:(id)sender
{
    self.diKuCunView.hidden = YES;
    self.yiShangJiaView.hidden = YES;
    self.tianJiaView.hidden = YES;
    self.shangPinKuView.hidden = NO;
    
    self.yiShangJiaButton.selected = NO;
    self.diKuCunButton.selected = NO;
    self.tianJiaShangPinButton.selected = NO;
    
    self.shangPinKuButton.selected = YES;
    self.tianJiaShangPinView.hidden = YES;
    
    self.shangPinKuButton.tintColor = [UIColor clearColor];
    [self.shangPinKuButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 104, 9);
    
    [self.shangPinKuButton addSubview:imageView];
}

- (IBAction)tianJiaShangPinAction:(id)sender
{
    self.diKuCunView.hidden = YES;
    self.shangPinKuView.hidden = YES;
    self.yiShangJiaView.hidden = YES;
    self.tianJiaView.hidden = NO;
    
    self.yiShangJiaButton.selected = NO;
    self.shangPinKuButton.selected = NO;
    self.diKuCunButton.selected = NO;
    
    self.tianJiaShangPinButton.selected = YES;
    
    self.tianJiaShangPinButton.tintColor = [UIColor clearColor];
    [self.tianJiaShangPinButton setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
    
    [imageView removeFromSuperview];
    imageView.frame = CGRectMake(0, 41, 104, 9);
    
    [self.tianJiaShangPinButton addSubview:imageView];
    
    if (self.tianJiaShangPinView.hidden == YES)
    {
        self.tianJiaShangPinView.hidden = NO;
        [self.view addSubview:self.tianJiaShangPinView];
    }
    
    else self.tianJiaShangPinView.hidden = YES;

}

- (IBAction)souSuoTextFiledHuiShouAction:(id)sender
{
    [self resignFirstResponder];
}

- (IBAction)tapViewAction:(id)sender
{
    [self.souSuoTextField resignFirstResponder];
}



- (IBAction)backAction:(id)sender
{
    self.navigationController.tabBarController.selectedIndex = 0;
}

- (IBAction)shangPin1Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)jiaGe1Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)kuCun1Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)zhuangTai1Action:(id)sender
{
    self.shangPin1Button.selected = NO;
    self.jiaGe1Button.selected = NO;
    self.kuCun1Button.selected = NO;
    self.fenLei1Button.selected = NO;
    
    UIButton * button = (UIButton*)sender;
    [self setButtonColor:button];
    
    if (self.zhuangTai1View.hidden == YES) {
        self.zhuangTai1View.hidden = NO;
    }
    else
        self.zhuangTai1View.hidden = YES;
}

- (IBAction)fenLei1Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
    
}




- (IBAction)shangPin2Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)jiaGe2Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)kuCun2Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)zhuangTai2Action:(id)sender
{
    self.shangPin2Button.selected = NO;
    self.jiaGe2Button.selected = NO;
    self.kuCun2Button.selected = NO;
    self.zengJia2Button.selected = NO;

    UIButton * button = (UIButton*)sender;
    [self setButtonColor:button];
    
    
    if (self.zhuangTai2View.hidden == YES) {
        self.zhuangTai2View.hidden = NO;
    }
    else
        self.zhuangTai2View.hidden = YES;
}

- (IBAction)zengJia2Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}


- (IBAction)shangPin3Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
    
}

- (IBAction)shengCan3Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)fenLei3Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)shangJia3Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}
- (IBAction)shangPin4Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}

- (IBAction)tianJia4Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    [self cancelAllButtonSelected];
    [self setButtonColor:button];
}
//设置选中按钮的颜色为浅蓝色
-(void)setButtonColor:(UIButton *)button
{
    button.selected = YES;
    button.tintColor = [UIColor clearColor];
    [button setTitleColor:[UIColor colorWithRed:13/255.00 green:111/255.00 blue:210/255.00 alpha:1.0] forState:(UIControlStateSelected)];
}
//取消下面View 选中zhuangt
-(void)cancelAllButtonSelected
{
    self.shangPin1Button.selected = NO;
    self.jiaGe1Button.selected = NO;
    self.kuCun1Button.selected = NO;
    self.zhuangTai1Button.selected = NO;
    self.fenLei1Button.selected = NO;
    self.shangPin2Button.selected = NO;
    self.jiaGe2Button.selected = NO;
    self.kuCun2Button.selected = NO;
    self.zhuangTai2Button.selected = NO;
    self.zengJia2Button.selected = NO;
    self.shangPin3Button.selected = NO;
    self.shengCan3Button.selected = NO;
    self.fenLei3Button.selected = NO;
    self.shangJia3Button.selected = NO;
    self.shangPin4Button.selected = NO;
    self.tianJia4Button.selected = NO;
    self.tianJiaShangPinView.hidden = YES;
    self.zhuangTai1View.hidden = YES;
    self.zhuangTai2View.hidden = YES;
}
- (IBAction)shangJia11Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    self.xiaJia11Button.selected = NO;
    [self setButtonColor:button];
    [button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}

- (IBAction)xiaJia11Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    self.shangJia11Button.selected = NO;
    [self setButtonColor:button];
    [button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}
- (IBAction)shangJia22Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    self.xiaJia22Button.selected = NO;
    [self setButtonColor:button];
    [button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}

- (IBAction)xiaJia22Action:(id)sender
{
    UIButton * button = (UIButton*)sender;
    self.shangJia22Button.selected = NO;
    [self setButtonColor:button];
    [button setBackgroundImage:[UIImage imageNamed:@"25.png"] forState:(UIControlStateSelected)];
}
@end
