//
//  CLUIViewController.m
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLUIViewController.h"
#import "UIViewCLFaster.h"
#import "CLCircleProgress.h"

@interface CLUIViewController ()

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;

@end

@implementation CLUIViewController{
    CLCircleProgress *_circleProgress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.button = [self createButton:CGRectMake(50, 150, 150, 40) title:@"drawCircle"];
//    [self.button addTarget:self action:@selector(drawCircle) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.button];
    
    //add circle
    _circleProgress = [[CLCircleProgress alloc]initWithFrame:CGRectMake(150, 100, 100, 100)];
    [self.view addSubview:_circleProgress];
    
    
    CLCircleProgress *c2 = [[CLCircleProgress alloc]initWithFrame:CGRectMake(150, 250, 100, 100)];
    [self.view addSubview:c2];
    [c2 show];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_circleProgress show];
}

-(UIButton *)createButton:(CGRect)frame title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setNormalTitle:title color:[UIColor blackColor]];
    [button setBorder:1 color:[UIColor blackColor]];
    [self.view addSubview:button];
    return button;
}

@end
