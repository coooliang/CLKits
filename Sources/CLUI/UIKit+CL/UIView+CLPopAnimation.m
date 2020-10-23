//
//  UIView+UIView_CLPopAnimation.m
//  Test
//
//  Created by chenliang on 24/10/2018.
//  Copyright © 2018 yypt. All rights reserved.
//

#import "UIView+CLPopAnimation.h"
#import <pop/POP.h>

#define WEAKSELF typeof(self) __weak weakSelf = self;
@implementation UIView (CLPopAnimation)

-(void)circle:(float)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)strokeColor{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:0 endAngle:10 clockwise:YES];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = lineWidth;
    pathLayer.strokeColor = strokeColor.CGColor;
    pathLayer.fillColor = nil; // 默认为blackColor
    pathLayer.path = path.CGPath;
    [self.layer addSublayer:pathLayer];
}

-(void)cl_line:(UIColor *)color width:(float)width points:(NSArray *)points {
    NSParameterAssert(points);
    UIBezierPath* path = [UIBezierPath bezierPath];
    NSValue *startPoint = [points objectAtIndex:0];
    [path moveToPoint:[startPoint CGPointValue]];
    
    for (int i=1; i<points.count; i++) {
        NSValue *p = points[i];
        [path addLineToPoint:[p CGPointValue]];
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = width;
    pathLayer.strokeColor = color.CGColor;
    pathLayer.fillColor = nil;
    pathLayer.path = path.CGPath;
    [self.layer addSublayer:pathLayer];
}

-(void)cl_fadeIn{
    [self cl_fadeIn:nil];
}
-(void)cl_fadeIn:(void(^)(void))block{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished && block) {
            block();
        }
    }];
    [self pop_addAnimation:anim forKey:nil];
}

-(void)cl_fadeOut{
    [self cl_fadeOut:nil];
}
-(void)cl_fadeOut:(void(^)(void))block{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.toValue = @(0.0);
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished && block) {
            block();
        }
    }];
    [self pop_addAnimation:anim forKey:nil];
}

-(void)cl_hide{
    [self cl_hide:nil];
}
-(void)cl_hide:(void(^)(void))block{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    springAnimation.toValue = [NSValue valueWithCGSize:CGSizeZero];
    [springAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished && block) {
            block();
        }
    }];
    [self pop_addAnimation:springAnimation forKey:nil];
}

-(void)cl_show{
    [self cl_show:nil];
}
-(void)cl_show:(void(^)(void))block{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    springAnimation.fromValue = [NSValue valueWithCGSize:CGSizeZero];
    springAnimation.toValue = [NSValue valueWithCGSize:self.frame.size];
    springAnimation.springBounciness = 10;
    [springAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished && block) {
            block();
        }
    }];
    [self pop_addAnimation:springAnimation forKey:nil];
}

-(void)cl_jelly{
    [self cl_jelly:nil];
}
-(void)cl_jelly:(void(^)(void))block{
    WEAKSELF
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95, 0.95)];
    scaleAnimation.springBounciness = 10.0f;
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (finished) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            POPSpringAnimation *scaleAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scaleAnimation2.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
            scaleAnimation2.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
            scaleAnimation2.springBounciness = 18.0f;
            [scaleAnimation2 setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                if (finished) {
                    POPBasicAnimation *scaleAnimation3 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                    scaleAnimation3.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
                    [scaleAnimation3 setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                        if (finished && block) {
                            block();
                        }
                    }];
                    [strongSelf.layer pop_addAnimation:scaleAnimation3 forKey:nil];
                }
            }];
            [weakSelf.layer pop_addAnimation:scaleAnimation2 forKey:nil];
        }
    }];
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
}

-(void)cl_shake{
    [self cl_shake:nil];
}
-(void)cl_shake:(void(^)(void))block{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x-10, self.center.y)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
    positionAnimation.springSpeed = 10;
    positionAnimation.springBounciness = 10;
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if(finished && block){
            block();
        }
    }];
    [self.layer pop_addAnimation:positionAnimation forKey:nil];
}

-(void)cl_move:(NSValue *)point,...NS_REQUIRES_NIL_TERMINATION {
    NSParameterAssert(point);
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [points addObject:point];
    
    va_list args;
    NSValue *p;
    va_start(args, point);
    while ((p = va_arg(args, NSValue *))) {
        [points addObject:p];
    }
    va_end(args);
    [self cl_spring_move:1 points:points block:nil];
}

-(void)cl_move:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION {
    NSParameterAssert(point);
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [points addObject:point];
    
    va_list args;
    NSValue *p;
    va_start(args, point);
    while ((p = va_arg(args, NSValue *))) {
        [points addObject:p];
    }
    va_end(args);
    [self cl_spring_move:1 points:points block:block];
}

- (void)cl_springMove:(NSValue *)point, ... NS_REQUIRES_NIL_TERMINATION {
    NSParameterAssert(point);
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [points addObject:point];
    
    va_list args;
    NSValue *p;
    va_start(args, point);
    while ((p = va_arg(args, NSValue *))) {
        [points addObject:p];
    }
    va_end(args);
     [self cl_spring_move:3 points:points block:nil];
}

-(void)cl_springMove:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION {
    NSParameterAssert(point);
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [points addObject:point];
    
    va_list args;
    NSValue *p;
    va_start(args, point);
    while ((p = va_arg(args, NSValue *))) {
        [points addObject:p];
    }
    va_end(args);
    [self cl_spring_move:3 points:points block:block];
}

#pragma mark - private move methods
-(void)cl_spring_move:(int)dynamicsMass points:(NSMutableArray *)points block:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSValue *v = [points firstObject];
        if(v){
            [points removeObjectAtIndex:0];
            WEAKSELF
            [self blockMove:v dynamicsMass:dynamicsMass block:^{
                [weakSelf cl_spring_move:dynamicsMass points:points block:block];
            }];
        }else{
            if (block) {
                block();
            }
        }
    });
}

-(void)blockMove:(NSValue *)v dynamicsMass:(int)dynamicsMass block:(void(^)(void))block{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = v;
    anim.dynamicsMass = dynamicsMass;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if(finished && block){
            block();
        }
    }];
    [self pop_addAnimation:anim forKey:nil];
}

#pragma mark -

@end
