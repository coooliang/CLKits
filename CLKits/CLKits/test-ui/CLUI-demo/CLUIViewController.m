//
//  CLUIViewController.m
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLUIViewController.h"
#import "UIViewCLFaster.h"


#import "CLAlertView.h"
#import "CLActionSheet.h"
#import "CLHUD.h"

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
    [[CLActionSheet new]show:@[@"hello",@"world",@"cancel"] block:^(int index) {
        NSLog(@"%d",index);
    }];
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
    [CLHUD showInfo:@"hello world"];
    [CLHUD showNotification:@"title" msg:@"hello world"];
}
@end
