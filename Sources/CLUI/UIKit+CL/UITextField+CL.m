//
//  UITextField+CL.m
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "UITextField+CL.h"

@implementation UITextField (CL)

-(void)cl_placeholder:(NSString *)placeholder{
    [self cl_placeholder:placeholder color:nil];
}
-(void)cl_placeholder:(NSString *)placeholder color:(UIColor *)color{
    [self cl_placeholder:placeholder color:color font:nil];
}
-(void)cl_placeholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font{
//    placeholder = safeString(placeholder);
    if (color == nil) {
        color = [UIColor grayColor];
    }
    @try {
        NSDictionary *attributes = @{NSForegroundColorAttributeName:color};
        if (font) {
            attributes = @{NSForegroundColorAttributeName:color,NSFontAttributeName:font};
        }
        NSAttributedString *attr = [[NSAttributedString alloc]initWithString:placeholder attributes:attributes];
        if (attr) {
            self.attributedPlaceholder = attr;
        }
    } @catch (NSException *exception) {
        NSLog(@"exception = %@",exception);
    } @finally {
        
    }
}

@end
