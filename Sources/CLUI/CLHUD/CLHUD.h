//
//  CLHUD.h
//  CLKits
//
//  Created by lion on 2019/2/18.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLHUD : NSObject


+(void)showProgressHUDInView:(UIView *)view;
+(void)hideProgressHUD;

+(void)showMaskInView:(UIView *)view;
+(void)hideMask;

@end

NS_ASSUME_NONNULL_END
