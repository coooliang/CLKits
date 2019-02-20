//
//  CLHUD.h
//  CLKits
//
//  Created by lion on 2019/2/18.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CLHUDDark,
    CLHUDLight
} CLHUDStyleType;

NS_ASSUME_NONNULL_BEGIN

@interface CLHUD : NSObject

+(void)setStyle:(CLHUDStyleType)type;

+(void)showCL:(UIView *)view;
+(void)hideCL;

+(void)showSV;
+(void)hideSV;

+(void)showToast:(NSString *)msg;
+(void)showInfo:(NSString *)msg;
+(void)showNotification:(NSString *)title msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
