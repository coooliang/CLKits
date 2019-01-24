//
//  CLDBViewController.m
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import "CLDBViewController.h"
#import "User.h"
#import "NSObject+CLDB.h"

@interface CLDBViewController ()

@end

@implementation CLDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [User CL_objectForId:@"1"];
    
    User *u = [[User alloc]init];
    [u CL_save];
}

@end
