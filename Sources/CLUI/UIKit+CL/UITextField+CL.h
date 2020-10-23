//
//  UITextField+CL.h
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITextField (CL)

-(void)cl_placeholder:(NSString *)placeholder;
-(void)cl_placeholder:(NSString *)placeholder color:(UIColor *)color;
-(void)cl_placeholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font;

@end
