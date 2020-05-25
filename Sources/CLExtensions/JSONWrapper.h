//
//  JSONWrapper.h
//  YinYin
//
//  Created by chenliang on 15/7/14.
//  Copyright © 2015年 yypt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONWrapper : NSObject

@end


@interface NSObject (JSONWrapper)

- (NSString *)objectToJSONString;

@end

@interface NSString (JSONWrapper)

- (id)JSONObject;
- (id)objectFromJSONString;

@end


@interface NSData (JSONWrapper)

- (NSString *)stringFromJSONData;

-(id)objectFromJSONString;

@end
