//
//  UIButton+CL.m
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "UIButton+CL.h"

@implementation UIButton (CL)

+(UIButton *)cl_button:(NSString *)title{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = true;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1;
    return button;
}


@end
