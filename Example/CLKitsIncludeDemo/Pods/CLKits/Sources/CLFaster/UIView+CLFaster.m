//
//  UIView+CLFaster.m
//  PopTest
//
//  Created by chenliang on 23/11/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "UIView+CLFaster.h"

#define ONE_SCALE (1/[UIScreen mainScreen].scale)
#define ONE_LINE_COLOR ([UIColor colorWithRed:0.871 green:0.871 blue:0.871 alpha:1])

@implementation UIView (CLFaster)

-(void)setCorner:(float)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
-(void)corner{
    [self setCorner:5];
}

-(void)setBorder:(float)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

+(UIView *)createHorizontalLine:(CGPoint)startPoint width:(float)width{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(startPoint.x, startPoint.y, width, ONE_SCALE)];
    line.backgroundColor = ONE_LINE_COLOR;
    return line;
}

+(UIView *)createVerticalLine:(CGPoint)startPoint height:(float)height{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(startPoint.x, startPoint.y, ONE_SCALE, height)];
    line.backgroundColor = ONE_LINE_COLOR;
    return line;
}

@end
