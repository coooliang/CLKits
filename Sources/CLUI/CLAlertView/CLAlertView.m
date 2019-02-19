//
//  CLAlertView.m
//  CLKits
//
//  Created by 陈亮 on 2019/2/1.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLAlertView.h"

typedef void (^CLAlertViewBlock)(int index);

@implementation CLAlertView{
    CLAlertViewBlock _alertClickBlock;
}

-(void)showInView:(UIView *)view title:(NSString *)title message:(NSString *)message buttons:(NSArray *)params block:(void(^)(int index))block{
    NSParameterAssert(params);
    _alertClickBlock = block;
    
}

@end
