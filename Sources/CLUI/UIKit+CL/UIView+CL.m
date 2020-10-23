//
//  UIView+CL.m
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "UIView+CL.h"

#define ONE_SCALE (1/[UIScreen mainScreen].scale)
#define ONE_LINE_COLOR ([UIColor colorWithRed:0.871 green:0.871 blue:0.871 alpha:1])

@implementation UIView (CL)

+(UIView *)cl_hline:(CGPoint)startPoint width:(float)width{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(startPoint.x, startPoint.y, width, ONE_SCALE)];
    line.backgroundColor = ONE_LINE_COLOR;
    return line;
}

+(UIView *)cl_vline:(CGPoint)startPoint height:(float)height{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(startPoint.x, startPoint.y, ONE_SCALE, height)];
    line.backgroundColor = ONE_LINE_COLOR;
    return line;
}

-(void)cl_corner:(float)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
-(void)cl_corner{
    [self cl_corner:5];
}

-(void)cl_border{
    [self cl_border:ONE_SCALE color:ONE_LINE_COLOR];
}
-(void)cl_border:(float)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}
@end
