//
//  NSString+Separate.h
//  YinYin
//
//  Created by chenliang on 15/5/21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NSSTRING_SEPARATE_ID @"id"//身份证 6,4,4,4
#define NSSTRING_SEPARATE_PHONE @"phone"//电话 3,4,4
#define NSSTRING_SEPARATE_CARD @"card"//银行 4, 4, 4, 4, 3

@interface NSString (Separate)

-(NSString *)cl_separate:(NSString *)type;

-(NSMutableDictionary *)cl_formatQRCodeBankName:(UIFont *)font labelWidth:(float)labelWidth;

-(NSString *)cl_formatTelPhone;

@end
