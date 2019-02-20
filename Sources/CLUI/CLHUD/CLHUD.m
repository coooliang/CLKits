//
//  CLHUD.m
//  CLKits
//
//  Created by lion on 2019/2/18.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLHUD.h"
#import "CLActivityIndicatorView.h"
#import "SVProgressHUD.h"


static CLActivityIndicatorView *_indicatorView;
static UIView *_maskBg;


@implementation CLHUD

+(void)load{
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
}

+(void)showCL:(UIView *)view{
    if (!_indicatorView) {
        _indicatorView = [[CLActivityIndicatorView alloc]initWithFrame:view.frame];
    }
    [view addSubview:_indicatorView];
    [_indicatorView startAnimat];
}
+(void)hideCL{
    if(_indicatorView)[_indicatorView stopAnimat];
}

+(void)showSV{
    [SVProgressHUD show];
}
+(void)hideSV{
    [SVProgressHUD dismiss];
}

+(void)showBarHUD:(NSString *)msg image:(UIImage *)image{
    
}

@end
