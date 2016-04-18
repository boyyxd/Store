

#import "MyTabBarViewController.h"
#import "RootViewController.h"
#import "DingDanViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImage];
}

#pragma mark --设置item图片--

-(void)setImage
{
        [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, nil] forState: UIControlStateNormal];
    
    
    
        UITabBarItem *item = [self.myTabBar.items objectAtIndex:0];
        [item setFinishedSelectedImage:[UIImage imageNamed:@"7(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"7.png"]];
    
        UITabBarItem *item1 = [self.myTabBar.items objectAtIndex:1];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"8(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"8.png"]];
    
    
    
        UITabBarItem *item2 = [self.myTabBar.items objectAtIndex:2];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"9(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"9.png"]];
    
        UITabBarItem *item3 = [self.myTabBar.items objectAtIndex:3];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"10(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"10.png"]];
    
        UITabBarItem *item4 = [self.myTabBar.items objectAtIndex:4];
      [item4 setFinishedSelectedImage:[UIImage imageNamed:@"11(1).png"] withFinishedUnselectedImage:[UIImage imageNamed:@"11.png"]];
        [[UITabBar appearance] setSelectedImageTintColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"7(1).png"]]];
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

@end
