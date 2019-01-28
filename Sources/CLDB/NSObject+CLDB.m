//
//  NSObject+CLDB.m
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import "NSObject+CLDB.h"
#import <objc/runtime.h>

#import <FMDB.h>

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
-(void)checkDB{
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
    //2.创建对应路径下数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [db open];
    if (![db open]) {
        NSLog(@"db open fail");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = [NSString stringWithFormat:@"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)"];
    for (NSString *p in [self getSaveProperties]) {
        //TODO:
    }
    
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
        
    }
    [db close];
}
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
-(NSString *)dbName{
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSString *dbName = [bundleId stringByReplacingOccurrencesOfString:@"." withString:@""];
    return dbName;
}
-(NSString *)tableName{
    return NSStringFromClass([self class]);
}
-(NSString *)primaryKey{
    return @"nid";
}

@end
