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

-(BOOL)cl_isMobile;
-(BOOL)cl_isIDCard;
-(BOOL)cl_isBankCard;
-(BOOL)cl_isSMS;
-(BOOL)cl_isEmail;
-(BOOL)cl_isURL;
@end

NS_ASSUME_NONNULL_END
