//
//  CLAlertView.m
//  CLKits
//
//  Created by lion on 2019/2/22.
//  Copyright © 2019 chenl. All rights reserved.
//

#define CLAlertViewGreenColor [UIColor colorWithRed:0.176 green:0.706 blue:0.459 alpha:1]
#define animateWithDuration_times 0.2

#import "CLAlertView.h"

@interface CLAlertView ()

@end

@implementation CLAlertView{
    UIView *_backgroundView;
    UIView *_whiteView;
    
    UIWindow *_CLAlertViewWindow;
    
    float _whiteWidth;
    float _whiteHeight;
}

-(void)initParams{
    _whiteWidth = 240;
    _whiteHeight = 100;
    _color = CLAlertViewGreenColor;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initParams];
        _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_backgroundView];
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _whiteWidth, _whiteHeight)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.center = self.view.center;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.masksToBounds = YES;
        [_backgroundView addSubview:_whiteView];
    }
    return self;
}

-(void)setClosed:(BOOL)closed{
    _closed = closed;
    _backgroundView.userInteractionEnabled = closed;
    if (closed) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        [_backgroundView addGestureRecognizer:tap];
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
}

-(void)show:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons block:(void(^)(int index))block{
    [self setButtons:buttons];
    [self showWindow];
}

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
-(void)setButtons:(NSArray *)buttons{
    if (buttons) {
        CGRect temp = _whiteView.frame;
        temp.size.height = _whiteHeight + buttons.count * 50;
        _whiteView.frame = temp;
        _whiteView.center = self.view.center;
        
        if (buttons.count == 1) {
            
        }else if(buttons.count == 2){
            for (int i=0;i<buttons.count;i++) {
                float w = (CGRectGetWidth(_whiteView.frame)-60)/2.0;
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(w*i+20, 50, w, 40)];
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
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 100 + 50*i, CGRectGetWidth(_whiteView.frame)-40, 40)];
                button.tag = i;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitle:buttons[i] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:button];
            }
        }
        
    }
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
@end
