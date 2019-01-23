//
//  UIButton+CLFaster.m
//  PopTest
//
//  Created by chenliang on 23/11/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "UIButton+CLFaster.h"

@implementation UIButton (CLFaster)

-(void)setNormalTitle:(NSString *)title color:(UIColor *)color{
    if(title)[self setTitle:title forState:UIControlStateNormal];
    if(color)[self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setHighTitle:(NSString *)title color:(UIColor *)color{
    if(title)[self setTitle:title forState:UIControlStateHighlighted];
    if(color)[self setTitleColor:color forState:UIControlStateHighlighted];
}
@end
