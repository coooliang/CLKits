//
//  NSObject+CLDB.h
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CLDB)

+(instancetype)CL_objectForId:(id)primaryKey;

-(void)CL_save;

@end

NS_ASSUME_NONNULL_END
