//
//  NSObject+JSON.m
//  CLKits
//
//  Created by lion on 2020/11/19.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

-(NSString *)cl_objectToJsonString{
    NSError* error = nil;
    id result = nil;
    NSData *data = nil;
    if ([self isKindOfClass:[NSData class]]) {
        data = (NSData *)self;
    }else if([self isKindOfClass:[NSString class]]){
        NSString *restring = [self performSelector:@selector(stringByReplacingOccurrencesOfString:withString:) withObject:@"\'" withObject:@"\""];
        data = [restring dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        if ([NSJSONSerialization isValidJSONObject:self]) {
            data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        }
    }
    if (data) {
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    if (error != nil) {
        return nil;
    }
    return result;
}

@end
