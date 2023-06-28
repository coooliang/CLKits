//// 
//  YYUserDefaults.m
//  CLKits
//  Created by chenl on 2023/3/14
//

#import "YYUserDefaults.h"
#import <YYCache.h>

static YYCache *_yyCache;
@implementation YYUserDefaults{
    YYCache *_yyCache;
}


+ (instancetype)standardUserDefaults {
    static YYUserDefaults *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _yyCache = [YYCache cacheWithName:NSStringFromClass(self.class)];
    }
    return self;
}

/// +resetStandardUserDefaults releases the standardUserDefaults and sets it to nil. A new standardUserDefaults will be created the next time it's accessed. The only visible effect this has is that all KVO observers of the previous standardUserDefaults will no longer be observing it.
+ (void)resetStandardUserDefaults {
    [_yyCache removeAllObjects];
}

/*!
 -objectForKey: will search the receiver's search list for a default with the key 'defaultName' and return it. If another process has changed defaults in the search list, NSUserDefaults will automatically update to the latest values. If the key in question has been marked as ubiquitous via a Defaults Configuration File, the latest value may not be immediately available, and the registered value will be returned instead.
 */
- (nullable id)objectForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}

/*!
 -setObject:forKey: immediately stores a value (or removes the value if nil is passed as the value) for the provided key in the search list entry for the receiver's suite name in the current user and any host, then asynchronously stores the value persistently, where it is made available to other processes.
 */
- (void)setObject:(nullable id)value forKey:(NSString *)defaultName {
    [_yyCache setObject:value forKey:defaultName];
}

/// -removeObjectForKey: is equivalent to -[... setObject:nil forKey:defaultName]
- (void)removeObjectForKey:(NSString *)defaultName {
    [_yyCache removeObjectForKey:defaultName];
}

/// -stringForKey: is equivalent to -objectForKey:, except that it will convert NSNumber values to their NSString representation. If a non-string non-number value is found, nil will be returned.
- (nullable NSString *)stringForKey:(NSString *)defaultName {
    NSString *s = [_yyCache objectForKey:defaultName];
    return s;
}

/// -arrayForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray.
- (nullable NSArray *)arrayForKey:(NSString *)defaultName {
    NSArray *arr = [_yyCache objectForKey:defaultName];
    return arr;
}
/// -dictionaryForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSDictionary.
- (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}
/// -dataForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSData.
- (nullable NSData *)dataForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}
/// -stringForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray<NSString *>. Note that unlike -stringForKey:, NSNumbers are not converted to NSStrings.
- (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}
/*!
 -integerForKey: is equivalent to -objectForKey:, except that it converts the returned value to an NSInteger. If the value is an NSNumber, the result of -integerValue will be returned. If the value is an NSString, it will be converted to NSInteger if possible. If the value is a boolean, it will be converted to either 1 for YES or 0 for NO. If the value is absent or can't be converted to an integer, 0 will be returned.
 */
- (NSInteger)integerForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}
/// -floatForKey: is similar to -integerForKey:, except that it returns a float, and boolean values will not be converted.
- (float)floatForKey:(NSString *)defaultName {
//    return [[_yyCache objectForKey:defaultName]floatValue];
    return 0;
}
/// -doubleForKey: is similar to -integerForKey:, except that it returns a double, and boolean values will not be converted.
- (double)doubleForKey:(NSString *)defaultName {
//    return [[_yyCache objectForKey:defaultName]doubleValue];
    return 0;
}
/*!
 -boolForKey: is equivalent to -objectForKey:, except that it converts the returned value to a BOOL. If the value is an NSNumber, NO will be returned if the value is 0, YES otherwise. If the value is an NSString, values of "YES" or "1" will return YES, and values of "NO", "0", or any other string will return NO. If the value is absent or can't be converted to a BOOL, NO will be returned.
 
 */
- (BOOL)boolForKey:(NSString *)defaultName {
    return [_yyCache objectForKey:defaultName];
}

/// -setInteger:forKey: is equivalent to -setObject:forKey: except that the value is converted from an NSInteger to an NSNumber.
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    return [_yyCache setObject:@(value) forKey:defaultName];
}
/// -setFloat:forKey: is equivalent to -setObject:forKey: except that the value is converted from a float to an NSNumber.
- (void)setFloat:(float)value forKey:(NSString *)defaultName {
    return [_yyCache setObject:@(value) forKey:defaultName];
}
/// -setDouble:forKey: is equivalent to -setObject:forKey: except that the value is converted from a double to an NSNumber.
- (void)setDouble:(double)value forKey:(NSString *)defaultName {
    return [_yyCache setObject:@(value) forKey:defaultName];
}
/// -setBool:forKey: is equivalent to -setObject:forKey: except that the value is converted from a BOOL to an NSNumber.
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    return [_yyCache setObject:@(value) forKey:defaultName];
}

/*!
 -dictionaryRepresentation returns a composite snapshot of the values in the receiver's search list, such that [[receiver dictionaryRepresentation] objectForKey:x] will return the same thing as [receiver objectForKey:x].
 */
- (NSDictionary<NSString *, id> *)dictionaryRepresentation {
    return nil;
}

@end
