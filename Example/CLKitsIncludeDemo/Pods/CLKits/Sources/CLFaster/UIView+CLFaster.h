//
//  UIView+CLFaster.h
//  PopTest
//
//  Created by chenliang on 23/11/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CLFaster)

-(void)setCorner:(float)radius;
-(void)corner;
-(void)setBorder:(float)width color:(UIColor *)color;

+(UIView *)createHorizontalLine:(CGPoint)startPoint width:(float)width;
+(UIView *)createVerticalLine:(CGPoint)startPoint height:(float)height;

@end

NS_ASSUME_NONNULL_END
