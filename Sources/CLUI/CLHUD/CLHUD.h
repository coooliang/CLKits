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


+(void)showCL:(UIView *)view;
+(void)hideCL;

+(void)showSV;
+(void)hideSV;

@end

NS_ASSUME_NONNULL_END
