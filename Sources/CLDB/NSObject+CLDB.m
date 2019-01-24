//
//  NSObject+CLDB.m
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import "NSObject+CLDB.h"
#import <objc/runtime.h>

@implementation NSObject (CLDB)

+(instancetype)CL_objectForId:(id)primaryKey{
    Class class = [self class];
    NSLog(@"class = %@",class);
    return nil;
}

-(void)CL_save{
    NSArray *arr = [self getSaveProperties];
    for (NSString *key in arr) {
        id value = [self valueForKey:key];
    }
}


#pragma mark - private methods
-(void)insert{
    
}
-(NSArray *)getSaveProperties{
    if ([self respondsToSelector:@selector(CL_useProperties)]) {
        return [self performSelector:@selector(CL_useProperties)];
    }
    return [self getAllProperties];
}

-(NSArray *)getAllProperties{
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++){
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    return propertiesArray;
}

#pragma mark - db name
-(NSString *)CL_dbName{
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSString *dbName = [bundleId stringByReplacingOccurrencesOfString:@"." withString:@""];
    return dbName;
}
-(NSString *)CL_tableName{
    return NSStringFromClass([self class]);
}
-(NSString *)CL_primaryKey{
    return @"nid";
}

@end
