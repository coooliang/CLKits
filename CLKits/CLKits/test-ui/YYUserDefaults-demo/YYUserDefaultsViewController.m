//// 
//  YYUserDefaultsViewController.m
//  CLKits
//  Created by chenl on 2023/3/14
//

#import "YYUserDefaultsViewController.h"
#import "EnvConstant.h"

@interface YYUserDefaultsViewController ()

@end

@implementation YYUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"setObject"];
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
