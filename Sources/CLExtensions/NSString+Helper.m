//
//  NSString+Helper.m
//  FormatFieldDemo
//
//  Created by lion on 2020/5/6.
//  Copyright © 2020 lion. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

/**
 判断字符串是否为手机号
 */
-(BOOL)cl_isMobile{
    NSString *mobile = [self clearSpaces];
    NSString *regexnumber = @"^1[0-9]{10}$";
    NSPredicate *numbertest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regexnumber];
    return [numbertest evaluateWithObject:mobile];
}

/**
 身份证号码的匹配
 */
-(BOOL)cl_isIDCard{
    NSString *idCard = [self clearSpaces];
    BOOL flag;
    if (self.length <= 0){
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:idCard];
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag){
        if(idCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[idCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [idCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}

/**
 银行卡号的匹配
 */
-(BOOL)cl_isBankCard{
    NSString *bankCard = [self clearSpaces];
    NSInteger card = [self integerValue];
    if (card > 0){
        char bit = [self getBankCardCheckCode:bankCard];
        if (bit == 'N') {
            return NO;
        }
        return [self UTF8String][[bankCard length]-1] == bit;
    }else{
        return NO;
    }
}

-(BOOL)cl_isSMS{
    NSString *sms = [self clearSpaces];
    NSString *regexnumber = @"^[0-9]{6}$";
    NSPredicate *numbertest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regexnumber];
    return [numbertest evaluateWithObject:sms];
}

/**
 判断字符串是否为邮箱
 */
-(BOOL)cl_isEmail{
    NSString *email = [self clearSpaces];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 判断字符串是否为标准URL
 */
-(BOOL)cl_isURL{
    NSString *url = [self clearSpaces];
    NSString *urlRegex = @"http(s)?://([\\w-]+\\.)+(/[\\w-./?%&=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
    return [urlTest evaluateWithObject:url];
}

-(BOOL)cl_isName:(NSString *)name{
    NSString *userRegex = @"^[a-zA-Z\u4e00-\u9fa5\u00b7]+$";
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userRegex];
    BOOL isUserMatch = [userPredicate evaluateWithObject:name];
    return isUserMatch;
}

#pragma mark - private methods
-(NSString *)clearSpaces{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(char)getBankCardCheckCode:(NSString *)string {
    const char *cvalue = [string UTF8String];
    int len = (int)strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return 'N';
        }
    }
    int luhmSum = 0;
    for(int i = len - 2, j = 0; i >= 0; i--, j++) {
        int k = cvalue[i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    return (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
}

BOOL isNumber (char ch){
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

@end
