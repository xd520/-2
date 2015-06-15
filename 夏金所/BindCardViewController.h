//
//  BindCardViewController.h
//  贵州金融资产股权交易
//
//  Created by Yonghui Xiong on 15-3-2.
//  Copyright (c) 2015年 ApexSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassBankCardViewController.h"

@interface BindCardViewController : UIViewController<ClassBankViewControllerDelegate,NetworkModuleDelegate>

@property (strong, nonatomic) NSString *pushStr;

@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *passID;
@property (weak, nonatomic) IBOutlet UILabel *bindCardLab;
@property (weak, nonatomic) IBOutlet UITextField *bankAccount;

@property (weak, nonatomic) IBOutlet UIButton *rember;
- (IBAction)remberBtn:(id)sender;
- (IBAction)commitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commit;
- (IBAction)back:(id)sender;

@end
