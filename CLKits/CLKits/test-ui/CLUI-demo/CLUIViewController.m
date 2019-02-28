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
#import "CLActionSheet.h"

#import "CLQRCode.h"

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
    
    UIButton *button2 = [self createButton:CGRectMake(50, 150, 100, 50) title:@"hud"];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [self createButton:CGRectMake(160, 150, 100, 50) title:@"mask"];
    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [self createButton:CGRectMake(270, 150, 100, 50) title:@"toast"];
    [button4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    CGFloat y = CGRectGetMaxY(button2.frame)+10;
    UIButton *button5 = [self createButton:CGRectMake(50, y, 100, 50) title:@"alert1"];
    [button5 addTarget:self action:@selector(click5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton *button6 = [self createButton:CGRectMake(160, y, 100, 50) title:@"alert2"];
    [button6 addTarget:self action:@selector(click6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    UIButton *button7 = [self createButton:CGRectMake(270, y, 100, 50) title:@"alert3"];
    [button7 addTarget:self action:@selector(click7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    y = CGRectGetMaxY(button7.frame)+10;
    UIButton *button8 = [self createButton:CGRectMake(50, y, 100, 50) title:@"alert4"];
    [button8 addTarget:self action:@selector(click8) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
    
    UIButton *button11 = [self createButton:CGRectMake(160, y, 100, 50) title:@"sheet"];
    [button11 addTarget:self action:@selector(sheet1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button11];
    
    UIButton *button12 = [self createButton:CGRectMake(270, y, 100, 50) title:@"barcode"];
    [button12 addTarget:self action:@selector(barcode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button12];
    
    y = CGRectGetMaxY(button12.frame)+10;
    UIButton *button13 = [self createButton:CGRectMake(50, y, 100, 50) title:@"qrcode"];
    [button13 addTarget:self action:@selector(qrcode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button13];
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
        NSLog(@"index = %d",index);
    }];
    
}

-(void)click6{
    CLAlertView *alert = [CLAlertView new];
    alert.color = [UIColor colorWithRed:0.757 green:0.152 blue:0.177 alpha:1.000];
    [alert show:@"温馨提示温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"取消",@"确定"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
}

-(void)click7{
    CLAlertView *alert = [CLAlertView new];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
}

-(void)click8{
    CLAlertView *alert = [CLAlertView new];
    alert.closed = YES;
    alert.image = [UIImage imageNamed:@"github"];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
    
}

-(void)sheet1{
    [[CLActionSheet new]show:@[@"选项1",@"选项2",@"选项3",@"cancel"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
}

-(void)qrcode{
    UIImage *image = [[CLQRCode new]createQRImageWithContent:@"http://www.baidu.com" size:CGSizeMake(280, 280) color:[UIColor blackColor] withLogo:[UIImage imageNamed:@"AppIcon"] logoSize:50];
    NSLog(@"%@",image);
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(50, 500, 280, 280)];
    iv.image = image;
    [self.view addSubview:iv];
}

-(void)barcode{
    UIImage *image = [[CLQRCode new]createBarImageWithContent:@"1234567890"];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(50, 500, 250, 80)];
    iv.image = image;
    [self.view addSubview:iv];
}

@end
