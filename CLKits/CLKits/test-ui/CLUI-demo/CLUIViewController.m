//
//  CLUIViewController.m
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLUIViewController.h"
#import "UIViewCLFaster.h"

#import "CLHUD.h"
#import "CLAlertView.h"


@interface CLUIViewController ()

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;

@end

@implementation CLUIViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.button = [self createButton:CGRectMake(50, 150, 150, 40) title:@"drawCircle"];
//    [self.button addTarget:self action:@selector(drawCircle) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.button];
    
    UIButton *button1 = [self createButton:CGRectMake(50, 200, 100, 50) title:@"alert"];
    [button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [self createButton:CGRectMake(50, 260, 100, 50) title:@"hud"];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [self createButton:CGRectMake(50, 320, 100, 50) title:@"mask"];
    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [self createButton:CGRectMake(50, 380, 100, 50) title:@"toast"];
    [button4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton *button5 = [self createButton:CGRectMake(50, 440, 100, 50) title:@"alert1"];
    [button5 addTarget:self action:@selector(click5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton *button6 = [self createButton:CGRectMake(160, 440, 100, 50) title:@"alert2"];
    [button6 addTarget:self action:@selector(click6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    UIButton *button7 = [self createButton:CGRectMake(50, 500, 100, 50) title:@"alert3"];
    [button7 addTarget:self action:@selector(click7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    UIButton *button8 = [self createButton:CGRectMake(160, 500, 100, 50) title:@"alert4"];
    [button8 addTarget:self action:@selector(click8) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(UIButton *)createButton:(CGRect)frame title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setNormalTitle:title color:[UIColor blackColor]];
    [button setBorder:1 color:[UIColor blackColor]];
    [self.view addSubview:button];
    return button;
}

-(void)click1{
    
}

-(void)click2{
    [CLHUD showCL:self.view];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideProgress) userInfo:nil repeats:NO];
}
-(void)hideProgress{
    [CLHUD hideCL];
}

-(void)click3{
    [CLHUD showSV];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideMask) userInfo:nil repeats:NO];
}
-(void)hideMask{
    [CLHUD hideSV];
}


-(void)click4{
//    [CLHUD setStyle:CLHUDLight];
    [CLHUD showToast:@"hello world"];
    [CLHUD showInfo:@"hello world"];
    [CLHUD showNotification:@"title" msg:@"hello world"];
}

-(void)click5{
    CLAlertView *alert = [CLAlertView new];
    alert.closed = YES;
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView " buttons:@[@"确定"] block:^(int index) {
        
    }];
}

-(void)click6{
    CLAlertView *alert = [CLAlertView new];
    alert.color = [UIColor colorWithRed:0.757 green:0.152 blue:0.177 alpha:1.000];
    [alert show:@"温馨提示温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"取消",@"确定"] block:^(int index) {
        
    }];
}

-(void)click7{
    CLAlertView *alert = [CLAlertView new];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        
    }];
}

-(void)click8{
    CLAlertView *alert = [CLAlertView new];
    alert.image = [UIImage imageNamed:@"github"];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        
    }];
}
@end
