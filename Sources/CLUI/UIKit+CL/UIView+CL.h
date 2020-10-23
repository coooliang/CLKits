//
//  UIView+CL.h
//  CLKits
//
//  Created by lion on 2020/10/23.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CL)

+(UIView *)cl_hline:(CGPoint)startPoint width:(float)width;
+(UIView *)cl_vline:(CGPoint)startPoint height:(float)height;

-(void)cl_corner:(float)radius;
-(void)cl_corner;

-(void)cl_border;
-(void)cl_border:(float)width color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
