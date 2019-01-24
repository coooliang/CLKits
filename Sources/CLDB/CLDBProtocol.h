//
//  CLDBProtocol.h
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CLDBProtocol <NSObject>

@optional
/**
 save db name

 @return db name
 */
-(NSString *)CL_dbName;


/**
 save table name

 @return table name
 */
-(NSString *)CL_tableName;


/**
 save Properties

 @return Properties array
 */
-(NSArray *)CL_useProperties;


@required
/**
 default primaryKey name is nid
 
 @return primaryKey name
 */
-(NSString *)CL_primaryKey;

@end

NS_ASSUME_NONNULL_END
