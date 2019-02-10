//
//  CLActionSheet.m
//  CLKits
//
//  Created by 陈亮 on 2019/2/1.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLActionSheet.h"
#import <UIKit/UIKit.h>

typedef void (^CLAlertViewBlock)(int index);

@implementation CLActionSheet{
    CLAlertViewBlock _alertClickBlock;
}

-(void)show:(NSArray *)params block:(void(^)(int index))block{
    NSParameterAssert(params);
    _alertClickBlock = block;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int index=0; index<params.count; index++) {
        int style = UIAlertActionStyleDefault;
        if (index == params.count-1) {
            style = UIAlertActionStyleDestructive;
        }
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:params[index] style:style handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(index);
            }
        }];
        [alertController addAction:alertAction];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
