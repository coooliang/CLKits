//
//  CLAlertView.m
//  CLKits
//
//  Created by lion on 2019/2/22.
//  Copyright © 2019 chenl. All rights reserved.
//

#define CLAlertViewGreenColor [UIColor colorWithRed:0.176 green:0.706 blue:0.459 alpha:1]
#define animateWithDuration_times 0.2

#define button_margin 20

#import "CLAlertView.h"

@interface CLAlertView ()<UIGestureRecognizerDelegate>

@end

@implementation CLAlertView{
    UIView *_backgroundView;
    UIView *_whiteView;
    
    UILabel *_titleLabel;
    UILabel *_messageLabel;
    
    UIWindow *_CLAlertViewWindow;
    
    float _whiteWidth;
    float _whiteHeight;
    float _buttonCount;
}

#pragma mark - init
-(void)initParams{
    _whiteWidth = 240;
    _whiteHeight = 180;
    _color = CLAlertViewGreenColor;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initParams];
        _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _backgroundView.tag = 1;
        [self.view addSubview:_backgroundView];
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _whiteWidth, _whiteHeight)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.center = self.view.center;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.masksToBounds = YES;
        _whiteView.userInteractionEnabled = YES;
        _whiteView.tag = 2;
        [_backgroundView addSubview:_whiteView];
    }
    return self;
}

#pragma mark - show
-(void)show:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons block:(void(^)(int index))block{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, CGRectGetWidth(_whiteView.frame)-100, 50)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = title;
    [_whiteView addSubview:_titleLabel];
    
    _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(button_margin, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_whiteView.frame)-button_margin*2, 50)];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.text = msg;
    _messageLabel.numberOfLines = 0;
    [_whiteView addSubview:_messageLabel];
    
    [self setButtons:buttons];
    
    [self calcHeight];
    
    [self showWindow];
}

#pragma mark - sets
-(void)setClosed:(BOOL)closed{
    _closed = closed;
    _backgroundView.userInteractionEnabled = closed;
    if (closed) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        tap.delegate = self;
        [_backgroundView addGestureRecognizer:tap];
        
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_whiteView.frame)-50, 0, 50, 50)];
        [closeButton setImage:[UIImage imageNamed:@"CLAlertViewCloseButton"] forState:UIControlStateNormal];
        [_whiteView addSubview:closeButton];
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect temp = _titleLabel.frame;
        temp.size.width = CGRectGetWidth(_whiteView.frame)-40;
        _titleLabel.frame = temp;
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
}

-(void)setButtons:(NSArray *)buttons{
    _buttonCount = buttons.count;
    if (buttons) {
        if (buttons.count == 1) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(button_margin, CGRectGetHeight(_whiteView.frame)-60, CGRectGetWidth(_whiteView.frame)-button_margin*2, 40)];
            button.tag = 0;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:buttons[0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            button.backgroundColor = _color;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_whiteView addSubview:button];
        }else if(buttons.count == 2){
            for (int i=0;i<buttons.count;i++) {
                float w = (CGRectGetWidth(_whiteView.frame)-button_margin*3)/2.0;
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(w*i+button_margin*(i+1), CGRectGetHeight(_whiteView.frame)-60, w, 40)];
                button.tag = i;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:buttons[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                button.backgroundColor = _color;
                button.layer.cornerRadius = 5;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:button];
            }
        }else{
            for (int i=0;i<buttons.count;i++) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(button_margin, CGRectGetHeight(_whiteView.frame)-60 + 60*i, CGRectGetWidth(_whiteView.frame)-button_margin*2, 40)];
                button.tag = i;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:buttons[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                button.backgroundColor = _color;
                button.layer.cornerRadius = 5;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:button];
            }
        }
        
    }
}

#pragma mark - private methods
-(void)showWindow{
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    alertWindow.windowLevel = UIWindowLevelAlert;
    alertWindow.backgroundColor = [UIColor clearColor];
    alertWindow.rootViewController = [UIViewController new];
    alertWindow.accessibilityViewIsModal = YES;
    [alertWindow.rootViewController addChildViewController:self];
    [alertWindow.rootViewController.view addSubview:self.view];
    _CLAlertViewWindow = alertWindow;
    [_CLAlertViewWindow makeKeyAndVisible];
    
    [self show:nil];
}

-(void)calcHeight{
    float th = 80;
    if (_buttonCount>2) {
        th += (_buttonCount-1)*60;
    }
    CGRect temp = _whiteView.frame;
    temp.size.height = CGRectGetHeight(_titleLabel.frame) + CGRectGetHeight(_messageLabel.frame) + th;
    _whiteView.frame = temp;
    _whiteView.center = self.view.center;
}

#pragma mark - clicks
-(void)close{
    NSLog(@"close...");
    [self hidden:^{
        [self->_CLAlertViewWindow setHidden:YES];
        self->_CLAlertViewWindow = nil;
    }];
}

-(void)click:(UIButton *)button{
    NSLog(@"button... %ld",(long)button.tag);
    [self close];
}

-(void)show:(void(^)(void))finishBlock{
    _whiteView.transform = CGAffineTransformMakeScale(0,0);
    [UIView animateWithDuration:animateWithDuration_times animations:^{
        self->_whiteView.transform = CGAffineTransformMakeScale(1,1);
    } completion:^(BOOL finished) {
        if(finishBlock != nil){
            finishBlock();
        }
    }];
}
-(void)hidden:(void(^)(void))finishBlock{
    self->_whiteView.transform = CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:animateWithDuration_times animations:^{
        self->_whiteView.transform = CGAffineTransformMakeScale(0.1,0.1);
    } completion:^(BOOL finished) {
        if(finishBlock != nil){
            finishBlock();
        }
    }];
}

#pragma mark - delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view.tag == 2) {
        return NO;
    }
    return YES;
}

@end
