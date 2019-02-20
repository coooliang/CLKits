//
//  ActivityIndicatorView.m
//  YinYin
//
//  Created by  on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CLActivityIndicatorView.h"
#import "CLColorfulActivityView.h"

@interface CLActivityIndicatorView ()

@property(nonatomic,strong)CLColorfulActivityView *indicatorView;
@property(nonatomic,strong)UIView *blackView;


@end
@implementation CLActivityIndicatorView{
    NSTimer *_timer;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        _timeOutSecond = 20;
        _blackView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-122)/2, (frame.size.height-53)/2, 122, 53)];
        _blackView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]; //
        _blackView.layer.shadowColor = [UIColor grayColor].CGColor;
        _blackView.layer.shadowOffset = CGSizeMake(0, 3);
        _blackView.layer.shadowOpacity = 0.5;
        _blackView.layer.shadowRadius = 6.0;
        _blackView.layer.cornerRadius = 10.0;
        _blackView.clipsToBounds = NO;
        // 添加等待动作视图
        _indicatorView = [[CLColorfulActivityView alloc] initWithFrame:CGRectMake((_blackView.bounds.size.width - 122) / 2, (_blackView.bounds.size.height - 53) / 2, 122, 53)];
        _indicatorView.backgroundColor = [UIColor clearColor];
        _indicatorView.layer.cornerRadius = 10; //圆角
        _indicatorView.layer.masksToBounds = YES;
        _indicatorView.layer.borderColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.00 blue:229.0/255.0 alpha:1].CGColor;
        _indicatorView.layer.borderWidth = 1.0f;

        [_blackView addSubview:_indicatorView];
        [self addSubview:_blackView];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.superview) {
        self.center = CGPointMake(self.superview.center.x, self.superview.center.y);
    }
}

-(void)startAnimat{
    [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardDidHideNotification object:nil];//隐藏键盘
    
    self.hidden = NO;
    [_indicatorView startAnimating];
    //20秒超时关闭
    if(_timer != nil){
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeOutSecond target:self selector:@selector(loadTimeOut) userInfo:nil repeats:NO];
}

-(void)stopAnimat{
    self.hidden = YES;
    [_indicatorView stopAnimating];
    //关闭timer
    if(_timer != nil){
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - private
- (void)loadTimeOut{
    [self stopAnimat];
    NSLog(@"loadTimeOut...");
    
    //关闭timer
    if(_timer != nil){
        [_timer invalidate];
        _timer = nil;
    }
}

@end
