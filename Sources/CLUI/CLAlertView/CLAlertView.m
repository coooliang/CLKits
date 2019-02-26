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


typedef void (^CLAlertViewClickCallback)(int index);

@interface CLAlertView ()<UIGestureRecognizerDelegate>

@end

@implementation CLAlertView{
    UIView *_backgroundView;
    UIView *_whiteView;
    
    UILabel *_titleLabel;
    UILabel *_messageLabel;
    UIView *_iconView;
    
    UIWindow *_CLAlertViewWindow;
    CLAlertViewClickCallback _block;
    
    float _whiteWidth;
    float _whiteHeight;
    float _buttonCount;
    
    NSString *_titleFontFamily;
    NSString *_msgTextFontFamily;
    NSString *_buttonsFontFamily;
    float _titleFontSize;
    float _msgFontSize;
    float _buttonsFontSize;
}

#pragma mark - init
-(void)initParams{
    _whiteWidth = 240;
    _whiteHeight = 190;
    _color = CLAlertViewGreenColor;
    
    _titleFontFamily = @"HelveticaNeue";
    _msgTextFontFamily = @"HelveticaNeue";
    _buttonsFontFamily = @"HelveticaNeue-Bold";
    _titleFontSize = 20.0f;
    _msgFontSize = 14.0f;
    _buttonsFontSize = 14.0f;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initParams];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        alertWindow.windowLevel = UIWindowLevelAlert;
        alertWindow.backgroundColor = [UIColor clearColor];
        alertWindow.rootViewController = [UIViewController new];
        alertWindow.accessibilityViewIsModal = YES;
        [alertWindow.rootViewController addChildViewController:self];
        [alertWindow.rootViewController.view addSubview:self.view];
        _CLAlertViewWindow = alertWindow;
        
        _backgroundView = [[UIView alloc]initWithFrame:_CLAlertViewWindow.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _backgroundView.tag = 1;
        
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _whiteWidth, _whiteHeight)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.center = self.view.center;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.masksToBounds = YES;
        _whiteView.userInteractionEnabled = YES;
        _whiteView.tag = 2;
        [self.view addSubview:_whiteView];
        
        
        // Add window subview
        [_CLAlertViewWindow.rootViewController addChildViewController:self];
        [_CLAlertViewWindow.rootViewController.view addSubview:_backgroundView];
        [_CLAlertViewWindow.rootViewController.view addSubview:self.view];
    }
    return self;
}

#pragma mark - show
-(void)show:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons block:(void(^)(int index))block{
    _block = block;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, CGRectGetWidth(_whiteView.frame)-40, 50)];
    _titleLabel.font = [UIFont fontWithName:_titleFontFamily size:_titleFontSize];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = title;
    [_whiteView addSubview:_titleLabel];
    
    
    float msgWidth = CGRectGetWidth(_whiteView.frame)-button_margin*2;
    UIFont *msgFont = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(msgWidth, 150);
    CGRect rect = [msg boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : msgFont} context:nil];
    
    
    _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(button_margin, CGRectGetMaxY(_titleLabel.frame), msgWidth, rect.size.height)];
    _messageLabel.font = [UIFont fontWithName:_msgTextFontFamily size:_msgFontSize];
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = msg;
    [_whiteView addSubview:_messageLabel];
    
    [self setButtons:buttons];
    
    [self calcHeight];//calc white bg height
    
    [self showWindow];
}

#pragma mark - sets
-(void)setClosed:(BOOL)closed{
    _closed = closed;
    self.view.userInteractionEnabled = closed;
    if (closed) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        tap.delegate = self;
        [self.view addGestureRecognizer:tap];
        
        //add close button
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_whiteView.frame)-50, 0, 50, 50)];
        [closeButton setImage:[UIImage imageNamed:@"CLAlertViewCloseButton"] forState:UIControlStateNormal];
        [_whiteView addSubview:closeButton];
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        //reset title width
        CGRect temp = _titleLabel.frame;
        temp.origin.x = 50;
        temp.size.width = CGRectGetWidth(_whiteView.frame)-100;
        _titleLabel.frame = temp;
    }
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    float w = 50;
    _iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w,w)];
    _iconView.backgroundColor = [UIColor whiteColor];
    _iconView.layer.cornerRadius = 50/2.0;
    _iconView.layer.masksToBounds = YES;
    _iconView.center = CGPointMake(_whiteView.center.x, CGRectGetMinY(_whiteView.frame));
    [self.view addSubview:_iconView];
    
    CGPoint iconCenter = CGPointMake(w/2.0, w/2.0); w = w-5;
    
    UIView *iconBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, w)];
    iconBG.backgroundColor = _color;
    iconBG.layer.cornerRadius = w/2.0;
    iconBG.layer.masksToBounds = YES;
    iconBG.center = iconCenter;
    [_iconView addSubview:iconBG];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    iv.backgroundColor = _color;
    iv.image = image;
    iv.layer.cornerRadius = CGRectGetWidth(iv.frame)/2.0;
    iv.layer.masksToBounds = YES;
    iv.center = iconCenter;
    [_iconView addSubview:iv];
}
-(void)setColor:(UIColor *)color{
    _color = color;
}

-(void)setButtons:(NSArray *)buttons{
    _buttonCount = buttons.count;
    if (buttons) {
        float y = CGRectGetMaxY(_messageLabel.frame)+20;
        if (buttons.count == 1) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(button_margin,y, CGRectGetWidth(_whiteView.frame)-button_margin*2, 40)];
            button.tag = 0;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:buttons[0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:_buttonsFontFamily size:_buttonsFontSize];
            button.backgroundColor = _color;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_whiteView addSubview:button];
        }else if(buttons.count == 2){
            for (int i=0;i<buttons.count;i++) {
                float w = (CGRectGetWidth(_whiteView.frame)-button_margin*3)/2.0;
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(w*i+button_margin*(i+1), y, w, 40)];
                button.tag = i;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:buttons[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont fontWithName:_buttonsFontFamily size:_buttonsFontSize];
                button.backgroundColor = _color;
                button.layer.cornerRadius = 5;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:button];
            }
        }else{
            for (int i=0;i<buttons.count;i++) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(button_margin, y + 60*i, CGRectGetWidth(_whiteView.frame)-button_margin*2, 40)];
                button.tag = i;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:buttons[i] forState:UIControlStateNormal];
                button.titleLabel.font =[UIFont fontWithName:_buttonsFontFamily size:_buttonsFontSize];
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
    [_CLAlertViewWindow makeKeyAndVisible];//show window
    [self show:nil];
}

-(void)calcHeight{
    float th = 80;
    if (_buttonCount>2) {
        th += (_buttonCount-1)*60;
    }
    
    CGRect temp = _whiteView.frame;
    temp.size.height = CGRectGetMaxY(_titleLabel.frame) + CGRectGetHeight(_messageLabel.frame) + th;
    _whiteView.frame = temp;
    _whiteView.center = self.view.center;
    
    if (_iconView) {
        _iconView.center = CGPointMake(_whiteView.center.x, CGRectGetMinY(_whiteView.frame));
    }
}

#pragma mark - clicks
-(void)close{
    [self close:-1];
}
-(void)close:(int)index{
    [self hidden:^{
        [self->_CLAlertViewWindow setHidden:YES];
        self->_CLAlertViewWindow = nil;
        
        if (self->_block) {
            self->_block(index);
        }
    }];
}

-(void)click:(UIButton *)button{
    [self close:(int)button.tag];
}

-(void)show:(void(^)(void))finishBlock{
    self.view.transform = CGAffineTransformConcat(CGAffineTransformIdentity,CGAffineTransformMakeScale(0.1f, 0.1f));
    
    self.view.alpha = 0.0f;
    [UIView animateWithDuration:animateWithDuration_times animations:^{
        self.view.transform = CGAffineTransformConcat(CGAffineTransformIdentity,CGAffineTransformMakeScale(1.0f, 1.0f));
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        if(finishBlock != nil){
            finishBlock();
        }
    }];
}
-(void)hidden:(void(^)(void))finishBlock{
    self.view.transform = CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:animateWithDuration_times animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.1,0.1);
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
