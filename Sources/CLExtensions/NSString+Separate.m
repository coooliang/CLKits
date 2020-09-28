//
//  NSString+Separate.m
//  YinYin
//
//  Created by chenliang on 15/5/21.
//
//

#import "NSString+Separate.h"
#import "EnvConstant.h"

@implementation NSString (Separate)

#pragma mark - 对字符串进行分析
-(NSString *)separate:(NSString *)type{
    if([@""isEqualToString:safeString(self)]){
        return @"";
    }
    
    NSMutableString *temp = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:@" " withString:@""]];//删除所有空格
    if([NSSTRING_SEPARATE_ID isEqualToString:type]){
        if(temp.length > 6){
            [temp insertString:@" " atIndex:6];
        }
        if(temp.length > 11){
            [temp insertString:@" " atIndex:11];
        }
        if(temp.length > 16){
            [temp insertString:@" " atIndex:16];
        }
    }else if([NSSTRING_SEPARATE_PHONE isEqualToString:type]){
        if(temp.length > 3){
            [temp insertString:@" " atIndex:3];
        }
        if(temp.length > 8){
            [temp insertString:@" " atIndex:8];
        }
    }else if([NSSTRING_SEPARATE_CARD isEqualToString:type]){
        if(temp.length > 4){
            [temp insertString:@" " atIndex:4];
        }
        if(temp.length > 9){
            [temp insertString:@" " atIndex:9];
        }
        if (temp.length > 14) {
             [temp insertString:@" " atIndex:14];
        }
        if (temp.length > 19) {
            [temp insertString:@" " atIndex:19];
        }
    }
    return temp;
}

//格式化银行卡为字典，仅用于b2c扫码显示
-(NSMutableDictionary *)formatQRCodeBankName:(UIFont *)font labelWidth:(float)labelWidth{
    NSString *lastNumber = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    [dict setObject:[NSString stringWithFormat:@"%f",labelWidth] forKey:@"width"];
    [dict setObject:lastNumber forKey:@"lastNumber"];
    NSString *bankName = self;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]};
    
    NSArray *arr = [bankName componentsSeparatedByString:@" "];
    if (arr && arr.count > 1) {
        bankName = arr[0];
        lastNumber = arr[1];
        
        CGSize textSize = [bankName boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [dict setObject:[NSString stringWithFormat:@"%f",textSize.width] forKey:@"originWidth"];
        if (textSize.width < labelWidth) {
            [dict setObject:[NSString stringWithFormat:@"%f",textSize.width] forKey:@"width"];
        }
        [dict setObject:lastNumber forKey:@"lastNumber"];
    }
    [dict setObject:bankName forKey:@"bankName"];
    return dict;
}

-(NSString *)formatTelPhone{
    if (self.length == 11) {
        NSString *firstNumber = [self substringToIndex:3];
        NSString *lastNumber = [self substringWithRange:NSMakeRange(7, 4)];
        return  [NSString stringWithFormat:@"%@***%@",firstNumber,lastNumber];
    }
    return self;
}
@end
