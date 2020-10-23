//
//  UILabel+CL.m
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "UILabel+CL.h"

@implementation UILabel (CL)

+(UILabel *)cl_label:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    return label;
}

@end
