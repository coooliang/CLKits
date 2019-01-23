//
//  CLCircleProgress.m
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLCircleProgress.h"

@implementation CLCircleProgress{
    CGFloat _timerProgress;
    
    CAShapeLayer *_downLayer;
    
    CAShapeLayer *_upLayer;
    
    UIView *_point;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _width = 2;
        _percent = 0.5;
        _backgroundColor = [UIColor lightGrayColor];
        _circleColor = [UIColor greenColor];
    }
    return self;
}

-(void)show{
    [self drawDownLayer];
    [self drawUpLayer];
}

-(void)drawDownLayer{
    if(!_downLayer){
        _downLayer = [[CAShapeLayer alloc]init];
        _downLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2) radius:self.bounds.size.width/2 startAngle:-M_PI_2 endAngle:M_PI*1.5 clockwise:YES];
        _downLayer.path = path.CGPath;
        _downLayer.lineWidth = self.width;
        _downLayer.lineCap = kCALineCapSquare;
        _downLayer.strokeColor = _backgroundColor.CGColor;
        _downLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_downLayer];
    }
}

-(void)drawUpLayer{
    if(!_upLayer){
        _upLayer = [[CAShapeLayer alloc]init];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = self.duration;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [_upLayer addAnimation:pathAnimation forKey:@"shapeLayerAnimation"];
        _upLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2) radius:self.bounds.size.width/2 startAngle:-M_PI_2 endAngle:sinf(M_PI*1.5*(_percent)) clockwise:YES];
        path.lineCapStyle = kCGLineCapRound;
        _upLayer.path = path.CGPath;
        _upLayer.lineWidth = self.width;
        _upLayer.lineCap = kCALineCapRound;
        _upLayer.strokeColor = _circleColor.CGColor;
        _upLayer.fillColor = [UIColor clearColor].CGColor;
        [_downLayer addSublayer:_upLayer];
    }
}

- (void)point{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = self.duration;
    pathAnimation.repeatCount = 0;
    float radiuscale = 1;
    CGFloat origin_x = self.frame.size.width/2;
    CGFloat origin_y = self.frame.size.height/2;
    CGFloat radiusX = self.frame.size.width/2;
    float a = -M_PI / 2;
    float b = (-M_PI / 2 + 2 * M_PI) * _percent;
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform t = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x, -origin_y),CGAffineTransformMakeScale(radiuscale, radiuscale)),
                                                  CGAffineTransformMakeTranslation(origin_x, origin_y));
    CGPathAddArc(path, &t, origin_x, origin_y, radiusX ,a , b, 0);
    pathAnimation.path = path;
    CGPathRelease(path);
    if(!_point){
        _point = [[UIView alloc] init];
        [self addSubview: _point];
        _point.frame = CGRectMake(self.bounds.size.width/2, 0, self.width*2+2, self.width*2+2);
        [_point.layer setCornerRadius:(self.width*2+2)/2];
        _point.backgroundColor = _circleColor;
        [_point.layer addAnimation:pathAnimation forKey:@"movePoint"];
    }
}

@end
