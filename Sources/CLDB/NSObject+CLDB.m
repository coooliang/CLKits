//
//  NSObject+CLDB.m
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import "NSObject+CLDB.h"

@implementation NSObject (CLDB)

+(instancetype)CL_objectForId:(id)primaryKey{
    Class class = [self class];
    NSLog(@"class = %@",class);
    return nil;
}

-(void)CL_save{
    
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
