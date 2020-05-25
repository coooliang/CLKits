//
//  PopingViewController.m
//  Test
//
//  Created by chenliang on 24/10/2018.
//  Copyright © 2018 yypt. All rights reserved.
//

#import "CLPopingViewController.h"
#import <POP.h>
#import "UIView+CLPopAnimation.h"
#import "UIViewCLFaster.h"

@interface CLPopingViewController ()

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@property(nonatomic,strong)UIButton *button4;
@property(nonatomic,strong)UIButton *button5;
@property(nonatomic,strong)UIButton *button6;
@property(nonatomic,strong)UIButton *button7;
@property(nonatomic,strong)UIButton *button8;
@property(nonatomic,strong)UIButton *button9;
@property(nonatomic,strong)UIButton *button10;

@end

@implementation CLPopingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    
    self.button = [self createButton:CGRectMake(50, 150, 150, 40) title:@"shake"];
    [self.button addTarget:self action:@selector(shake) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    self.button2 = [self createButton:CGRectMake(50, 200, 150, 40) title:@"springMove"];
    [self.button2 addTarget:self action:@selector(springMove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    
    self.button3 = [self createButton:CGRectMake(50, 250, 150, 40) title:@"move"];
    [self.button3 addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    
    self.button4 = [self createButton:CGRectMake(50, 300, 150, 40) title:@"jelly"];
    [self.button4 addTarget:self action:@selector(jelly) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button4];
    
    self.button6 = [self createButton:CGRectMake(50, 400, 150, 40) title:@"hide"];
    [self.button6 addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button6];
    
    
    self.button8 = [self createButton:CGRectMake(50, 500, 150, 40) title:@"fadeOut"];
    [self.button8 addTarget:self action:@selector(fadeOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button8];
    
    self.button9 = [self createButton:CGRectMake(50, 550, 150, 40) title:@"line"];
    [self.button9 addTarget:self action:@selector(line) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button9];
    
    self.button10 = [self createButton:CGRectMake(50, 600, 150, 40) title:@"circle"];
    [self.button10 addTarget:self action:@selector(circle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button10];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.button5 = [self createButton:CGRectMake(50, 350, 150, 40) title:@"show"];
    [self.button5 addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button5];
    [self.button5 cl_show];
    
    self.button7 = [self createButton:CGRectMake(50, 450, 150, 40) title:@"fadeIn"];
    [self.button7 addTarget:self action:@selector(fadeIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button7];
    [self.button7 cl_fadeIn];
}

-(UIButton *)createButton:(CGRect)frame title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setNormalTitle:title color:[UIColor blackColor]];
    [button setBorder:1 color:[UIColor blackColor]];
    [self.view addSubview:button];
    return button;
}

#pragma mark - actions
-(void)circle{
    [self.view circle:150 lineWidth:6 color:[UIColor blackColor]];
}
-(void)line{
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(100, 200)],[NSValue valueWithCGPoint:CGPointMake(150, 150)]];
    
    [self.view cl_line:[UIColor greenColor] width:4 points:points];
    
}
-(void)fadeIn{
    [self.button7 cl_fadeIn];
}
-(void)fadeOut{
    [self.button8 cl_fadeOut];
}
-(void)hide{
    [self.button6 cl_hide:^{
        NSLog(@"hide");
        [self.button6 removeFromSuperview];
    }];
}
-(void)show{
    [self.button5 cl_show];
}
-(void)jelly{
    [self.button4 cl_jelly];
}
-(void)shake{
    [self.button cl_shake];
}
-(void)springMove{
    //[self.button2 springMove...];
    [self.button2 cl_springMove:^{
        NSLog(@"springMove block");
    } point:[NSValue valueWithCGPoint:CGPointMake(200, 300)],[NSValue valueWithCGPoint:CGPointMake(200, 400)], nil];
}
-(void)move{
    [self.button3 cl_move:[NSValue valueWithCGPoint:CGPointMake(200, 300)],[NSValue valueWithCGPoint:CGPointMake(200, 450)],nil];
}

- (void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}

@end
