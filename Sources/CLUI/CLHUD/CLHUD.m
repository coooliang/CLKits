//
//  CLHUD.m
//  CLKits
//
//  Created by lion on 2019/2/18.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLHUD.h"
#import "ActivityIndicatorView.h"


static ActivityIndicatorView *_indicatorView;
static UIActivityIndicatorView *_aiv;


@implementation CLHUD

+(void)showProgressHUDInView:(UIView *)view{
    if (!_indicatorView) {
        _indicatorView = [[ActivityIndicatorView alloc]initWithFrame:view.frame];
    }
    [view addSubview:_indicatorView];
    [_indicatorView startAnimat];
}

+(void)hideProgressHUD{
    if(_indicatorView)[_indicatorView stopAnimat];
}

+(void)showMaskInView:(UIView *)view{
    if (!_aiv) {
        _aiv = [[UIActivityIndicatorView alloc]init];
        _aiv.center = view.center;
        _aiv.color = [UIColor blackColor];
    }
    [view addSubview:_aiv];
    [_aiv startAnimating];
}
+(void)hideMask{
    [_aiv stopAnimating];
}

+(void)showBarHUD:(NSString *)msg image:(UIImage *)image{
    
}

@end
