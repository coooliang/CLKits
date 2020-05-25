//
//  UITestBaseViewController.h
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITestBaseViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arr;

-(UITableViewCell *)createTableViewCell:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
