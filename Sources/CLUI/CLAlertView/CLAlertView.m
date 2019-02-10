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

-(void)show:(NSString *)title message:(NSString *)message buttons:(NSArray *)params block:(void(^)(int index))block{
    NSParameterAssert(params);
    _alertClickBlock = block;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int index=0; index<params.count; index++) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:params[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(index);
            }
        }];
        [alertController addAction:alertAction];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
