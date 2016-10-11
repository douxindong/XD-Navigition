//
//  RootViewController.m
//  XD-Navigition
//
//  Created by 窦心东 on 16/10/11.
//  Copyright © 2016年 窦心东. All rights reserved.
//

#import "RootViewController.h"
#import "XDViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RootViewController";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bgcolor"] forBarMetrics:UIBarMetricsDefault];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, CGRectGetMidX(self.view.frame), SCREEN_WIDTH/2, 48)];
    [button setBackgroundColor: [UIColor grayColor]];
    [button setTitle:@"进入下拉透明界面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)buttonClick{
    [self.navigationController pushViewController:[XDViewController new] animated:YES];
    
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
