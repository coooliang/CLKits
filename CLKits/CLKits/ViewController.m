//
//  ViewController.m
//  CLKit
//
//  Created by chenliang on 03/12/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "ViewController.h"

#import "EnvConstant.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"CLPopingViewController",@"CLNetworkingViewController",@"CLDBViewController",@"CLUIViewController",@"YYUserDefaultsViewController"];
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
    NSString *className =  [self.arr objectAtIndex:index];
    Class cls = NSClassFromString(className);
    UIViewController *vc = [[cls alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
