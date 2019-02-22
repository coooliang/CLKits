//
//  CLAlertView.m
//  CLKits
//
//  Created by lion on 2019/2/22.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLAlertView.h"

@interface CLAlertView ()

@end

@implementation CLAlertView{
    UIView *_backgroundView;
    UIView *_whiteView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_backgroundView];
        
        float width = 225;
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 100)];
        _whiteView.center = self.view.center;
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

-(void)show:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons block:(void(^)(int index))block{
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
    [alertWindow makeKeyAndVisible];
}
-(void)setButtons:(NSArray *)buttons{
    if (buttons) {
        for (int i=0;i<buttons.count;i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
            button.tag = i;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:buttons[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundView addSubview:button];
        }
    }
}

#pragma mark - clicks
-(void)close{
    NSLog(@"close...");
}

-(void)click:(UIButton *)button{
    NSLog(@"button... %ld",(long)button.tag);
}

@end
