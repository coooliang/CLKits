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
#import "EnvConstant.h"

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
    
    self.arr = @[@"getData",@"postData",@"getJson",@"postJson",@"upload",@"download",@"soap"];
    
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
    NSString *methodName =  [self.arr objectAtIndex:index];
    SEL sel = NSSelectorFromString(methodName);
    if ([self respondsToSelector:sel]) {
        SuppressPerformSelectorLeakWarning([self performSelector:sel]);
    }
    
}


@end
