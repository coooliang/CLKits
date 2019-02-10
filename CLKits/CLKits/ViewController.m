//
//  ViewController.m
//  CLKit
//
//  Created by chenliang on 03/12/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "ViewController.h"

#import "CLPopingViewController.h"
#import "CLNetworkingViewController.h"
#import "CLDBViewController.h"
#import "CLUIViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *getDataButton = [self createButton:@"CLPopAnimation" frame:CGRectMake(20, 100, 150, 40)];
    [getDataButton addTarget:self action:@selector(CLPopAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getDataButton];
    
    UIButton *getJsonButton = [self createButton:@"CLNetworking" frame:CGRectMake(20, 180, 150, 40)];
    [getJsonButton addTarget:self action:@selector(CLNetworking) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getJsonButton];
    
    UIButton *dbButton = [self createButton:@"CLDB" frame:CGRectMake(20, 260, 150, 40)];
    [dbButton addTarget:self action:@selector(CLDB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dbButton];
    
    UIButton *uiButton = [self createButton:@"CLUI" frame:CGRectMake(20, 320, 150, 40)];
    [uiButton addTarget:self action:@selector(CLUI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uiButton];
}

-(UIButton *)createButton:(NSString *)title frame:(CGRect)frame{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

-(void)CLPopAnimation{
    CLPopingViewController *pop = [[CLPopingViewController alloc]init];
    [self.navigationController pushViewController:pop animated:YES];
}

-(void)CLNetworking{
    CLNetworkingViewController *net = [[CLNetworkingViewController alloc]init];
    [self.navigationController pushViewController:net animated:YES];
}

-(void)CLDB{
    CLDBViewController *db = [[CLDBViewController alloc]init];
    [self.navigationController pushViewController:db animated:YES];
}

-(void)CLUI{
    CLUIViewController *ui = [[CLUIViewController alloc]init];
    [self.navigationController pushViewController:ui animated:YES];
}

@end
