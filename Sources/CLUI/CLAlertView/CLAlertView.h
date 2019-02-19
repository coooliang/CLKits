//
//  CLAlertView.h
//  CLKits
//
//  Created by 陈亮 on 2019/2/1.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CLSystemAlert,
    CLCustomAlert,
    SCLAlertView,
} CLAlertViewType;

NS_ASSUME_NONNULL_BEGIN

@interface CLAlertView : NSObject

-(UIView *)showInView:(UIView *)view title:(NSString *)title message:(NSString *)message buttons:(NSArray *)params block:(void(^)(int index))block;

@end

NS_ASSUME_NONNULL_END
