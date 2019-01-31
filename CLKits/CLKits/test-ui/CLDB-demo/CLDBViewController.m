//
//  CLDBViewController.m
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import "CLDBViewController.h"
#import "User.h"


@interface CLDBViewController ()

@end

@implementation CLDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User new];
    user.userName = @"hello";
    [user saveOrUpdate];
    
    NSLog(@"users = %@",[User findAll]);
}

@end
