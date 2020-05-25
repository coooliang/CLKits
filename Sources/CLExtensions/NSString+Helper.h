//
//  NSString+Helper.h
//  FormatFieldDemo
//
//  Created by lion on 2020/5/6.
//  Copyright © 2020 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Helper)

+ (BOOL)isMobilePhone:(NSString *)phone;
+ (BOOL)isIDCard:(NSString *)idcard;
+ (BOOL)isBankCard:(NSString *)bankcard;
+ (BOOL)isSMS:(NSString *)sms;

+ (BOOL)isEmail:(NSString *)email;
+ (BOOL)isURL:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
