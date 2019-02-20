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
#import "FTIndicator.h"


static CLActivityIndicatorView *_indicatorView;
static UIView *_maskBg;


@implementation CLHUD

+(void)setStyle:(CLHUDStyleType)type{
    if (type == CLHUDDark) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
        [FTIndicator setIndicatorStyle:UIBlurEffectStyleDark];
    }else{
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
        [FTIndicator setIndicatorStyle:UIBlurEffectStyleLight];
    }
}
+(void)load{
    [CLHUD setStyle:CLHUDDark];
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

+(void)showToast:(NSString *)msg{
    [FTIndicator showToastMessage:msg];
}
+(void)showInfo:(NSString *)msg{
    [FTIndicator showInfoWithMessage:msg];
}

+(void)showNotification:(NSString *)title msg:(NSString *)msg{
    [FTIndicator showNotificationWithTitle:title message:msg];
}
@end
