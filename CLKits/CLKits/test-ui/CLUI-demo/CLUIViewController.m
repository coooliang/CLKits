//
//  CLUIViewController.m
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLUIViewController.h"

#import "EnvConstant.h"

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
    
    self.arr = @[@"show CL loading",
                 @"hide CL loading",
                 @"show SV loading",
                 @"hide SV loading",
                 @"HUB",
                 @"alert",
                 @"alert two button",
                 @"alert 3",
                 @"alert 4",
                 @"sheet",
                 @"qrcode",
                 @"barcode"];
}

-(void)showCL{
    [CLHUD showCL:self.view];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideCL) userInfo:nil repeats:NO];
}
-(void)hideCL{
    [CLHUD hideCL];
}

-(void)showSV{
    [CLHUD showSV];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideSV) userInfo:nil repeats:NO];
}
-(void)hideSV{
    [CLHUD hideSV];
}


-(void)show{
//    [CLHUD setStyle:CLHUDLight];
    [CLHUD showToast:@"hello world"];
    [CLHUD showInfo:@"hello world"];
    [CLHUD showNotification:@"title" msg:@"hello world"];
}

-(void)click1{
    CLAlertView *alert = [CLAlertView new];
    alert.closed = YES;
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView " buttons:@[@"确定"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
    
}

-(void)click2{
    CLAlertView *alert = [CLAlertView new];
    alert.color = [UIColor colorWithRed:0.757 green:0.152 blue:0.177 alpha:1.000];
    [alert show:@"温馨提示温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"取消",@"确定"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
}

-(void)click3{
    CLAlertView *alert = [CLAlertView new];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
}

-(void)click4{
    CLAlertView *alert = [CLAlertView new];
    alert.closed = YES;
    alert.image = [UIImage imageNamed:@"github"];
    [alert show:@"温馨提示" msg:@"您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView 您好，欢迎使用CLAlertView自定义AlertView" buttons:@[@"提示按钮1",@"提示按钮2",@"提示按钮3",@"提示按钮1",@"提示按钮2",@"提示按钮3"] block:^(int index) {
        NSLog(@"index = %d",index);
    }];
    
}

-(void)sheet{
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

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.arr objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self createTableViewCell:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    NSString *methodName = [self.arr objectAtIndex:index];
    SEL sel = NSSelectorFromString(methodName);
    if ([self respondsToSelector:sel]) {
        SuppressPerformSelectorLeakWarning([self performSelector:sel]);
    }
}

@end
 
