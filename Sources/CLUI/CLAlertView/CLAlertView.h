//
//  CLAlertView.h
//  CLKits
//
//  Created by 陈亮 on 2019/2/1.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLAlertView : NSObject

-(void)show:(NSString *)title message:(NSString *)message buttons:(NSArray *)params block:(void(^)(int index))block;

@end

NS_ASSUME_NONNULL_END
