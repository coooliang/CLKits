//
//  ColorfulActivityView4.m
//  YinYin
//
//  Created by Lin Wei on 2017/2/22.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CLColorfulActivityView.h"

@interface CLColorfulActivityView ()

@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UIImageView *animatedCircleImageView;
@property(nonatomic, assign) float angle;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UILabel *tipLabel;
@property(nonatomic, strong) UILabel *dotLabel;
@property(nonatomic, assign) float secondPerCircle;

@end

@implementation CLColorfulActivityView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initActivityView:frame];
    }
    return  self;
}

-(void)initActivityView:(CGRect)bounds{
    CGSize size = bounds.size;
    _angle = 0;
    _logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ViewMaskCenter"]];//48 × 24
    [self addSubview:_logoImageView];
    _animatedCircleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ViewMaskAnimatedCircle"]];//73 × 74
    [_animatedCircleImageView setFrame:CGRectMake(8, (size.height - 37) / 2, 37, 37)];
    
    CGPoint center = _animatedCircleImageView.center;
    _logoImageView.frame = CGRectMake(0, 0, 24, 12);
    _logoImageView.center = center;
    [self addSubview:_animatedCircleImageView];
    
    UIColor *textColor = [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1];
    _dotLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width - 8 - 16, 8, 16, size.height - 16)];
    _dotLabel.textAlignment = NSTextAlignmentLeft;
    _dotLabel.text = @"";
    _dotLabel.font = [UIFont boldSystemFontOfSize:14];
    _dotLabel.textColor = textColor;
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_dotLabel.frame) - 48, 8, 48, size.height - 16)];
    _tipLabel.textAlignment = NSTextAlignmentRight;
    _tipLabel.text = @"载入中";
    _tipLabel.font =[UIFont boldSystemFontOfSize:14];
    _tipLabel.textColor = textColor;
    
    _secondPerCircle = 1.5;
    
    [self addSubview:_dotLabel];
    [self addSubview:_tipLabel];
}

-(void)startAnimating
{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval: _secondPerCircle / 36 target: self selector:@selector(hadleTimer:) userInfo: nil repeats: YES];
}

-(void)hadleTimer:(NSTimer *)timer {
    //每圈36个动画
    _angle += 2 * M_PI / 36;
    float actualAngle = _angle - floor(_angle /(2 * M_PI)) * 2 * M_PI;
    //每帧对应的 ... 个数
    NSInteger count = floor(actualAngle / (2 * M_PI / 36) / (36 / 4));
    NSString *dot = @"";
    for(int i = 0; i < count ; i++) {
        dot = [NSString stringWithFormat:@"%@.", dot];
    }
    _dotLabel.text = dot;
    [_animatedCircleImageView setTransform:CGAffineTransformMakeRotation(_angle)];
}

-(void)stopAnimating
{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc
{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
