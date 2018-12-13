//
//  UIView+UIView_CLPopAnimation.h
//  Test
//
//  Created by chenliang on 24/10/2018.
//  Copyright © 2018 yypt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CLPopAnimation)

-(void)cl_line:(UIColor *)color width:(float)width points:(NSArray *)points;
-(void)circle:(float)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)strokeColor;

-(void)cl_fadeIn;
-(void)cl_fadeIn:(nullable void(^)(void))block;

-(void)cl_fadeOut;
-(void)cl_fadeOut:(nullable void(^)(void))block;

-(void)cl_show;
-(void)cl_show:(nullable void(^)(void))block;

-(void)cl_hide;
-(void)cl_hide:(nullable void(^)(void))block;

-(void)cl_jelly;
-(void)cl_jelly:(nullable void(^)(void))block;

-(void)cl_shake;
-(void)cl_shake:(nullable void(^)(void))block;

-(void)cl_move:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;
-(void)cl_move:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;

-(void)cl_springMove:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;
-(void)cl_springMove:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
