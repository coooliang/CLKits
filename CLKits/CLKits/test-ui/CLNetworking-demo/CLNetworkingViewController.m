//
//  CLNetworkingViewController.m
//  CLKit
//
//  Created by chenliang on 06/12/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLNetworkingViewController.h"
#import "UIViewCLFaster.h"
#import "CLNetworking.h"

@interface CLNetworkingViewController ()

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@property(nonatomic,strong)UIButton *button4;
@property(nonatomic,strong)UIButton *button5;
@property(nonatomic,strong)UIButton *button6;
@property(nonatomic,strong)UIButton *button7;
@property(nonatomic,strong)UIButton *button8;

@end

@implementation CLNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [self createButton:CGRectMake(50, 150, 150, 40) title:@"getData"];
    [self.button addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.button2 = [self createButton:CGRectMake(50, 200, 150, 40) title:@"postData"];
    [self.button2 addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    
    self.button3 = [self createButton:CGRectMake(50, 300, 150, 40) title:@"getJson"];
    [self.button3 addTarget:self action:@selector(getJson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    
    self.button4 = [self createButton:CGRectMake(50, 350, 150, 40) title:@"postJson"];
    [self.button4 addTarget:self action:@selector(postJson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button4];
    
    self.button5 = [self createButton:CGRectMake(50, 450, 150, 40) title:@"upload"];
    [self.button5 addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button5];
    
    self.button7 = [self createButton:CGRectMake(50, 550, 150, 40) title:@"download"];
    [self.button7 addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button7];
    
    self.button8 = [self createButton:CGRectMake(50, 600, 150, 40) title:@"soap"];
    [self.button8 addTarget:self action:@selector(soap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button8];
}

-(UIButton *)createButton:(CGRect)frame title:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setNormalTitle:title color:[UIColor blackColor]];
    [button setBorder:1 color:[UIColor blackColor]];
    [self.view addSubview:button];
    return button;
}

-(void)getData{
    [[CLNetworking sharedInstance]getData:@"https://www.yypt.com/finmobile2/financing/ver4/home!pageCfgFour.do" params:nil successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    }];
}

-(void)postData{
    [[CLNetworking sharedInstance]postData:@"https://www.yypt.com/finmobile2/financing/ver4/home!pageCfgFour.do" params:nil successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    }];
}
-(void)getJson{
    [[CLNetworking sharedInstance]getJson:@"https://www.yypt.com/finmobile2/financing/ver4/home!pageCfgFour.do" params:nil successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    }];
}
-(void)postJson{
    [[CLNetworking sharedInstance]postJson:@"https://www.yypt.com/finmobile2/financing/ver4/home!pageCfgFour.do" params:nil successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    }];
}
-(void)upload{
    UIImage *image = [UIImage imageNamed:@"temp"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [[CLNetworking sharedInstance]upload:@"http://10.1.4.68:8080/UploadImagesDemo/UploadServlet" datas:@[data] fileName:@"3.png" parameters:nil successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } progressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"progress = %@",progress);
    }];
}

-(void)download{
    [[CLNetworking sharedInstance]download:@"http://10.1.4.68:8080/UploadImagesDemo/upload/1.PNG" fileName:@"2.png" successBlock:^(NSURL * _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(NSError * _Nonnull result) {
        NSLog(@"result = %@",result);
    } progressBlock:^(NSProgress * _Nonnull progress) {
        NSLog(@"progress = %@",progress);
    }];
}
-(void)soap{
    //just like this
    NSString *soapXmlString = @"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\"><soap:Body><GetItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\" xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\"><ItemShape><t:BaseShape>AllProperties</t:BaseShape><t:IncludeMimeContent>false</t:IncludeMimeContent></ItemShape><ItemIds><t:ItemId Id=\"%@\" ChangeKey=\"%@\" /></ItemIds></GetItem></soap:Body></soap:Envelope>";
    
    NSString *url = @"https://mail.xxx.com/ews/exchange.asmx";
    
    [[CLNetworking sharedInstance]soap:soapXmlString url:url user:@{@"username":@"",@"password":@""} successBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    } failBlock:^(id  _Nonnull result) {
        NSLog(@"result = %@",result);
    }];
}
@end
