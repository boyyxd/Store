//
//  LoginViewController.h
//  Store
//
//  Created by mm on 15/1/23.
//  Copyright (c) 2015年 mm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)zhuCeAction:(id)sender;

- (IBAction)nameTextField_DidEndOnExit:(id)sender;
- (IBAction)passTextField_DidEndOnExit:(id)sender;

@end
