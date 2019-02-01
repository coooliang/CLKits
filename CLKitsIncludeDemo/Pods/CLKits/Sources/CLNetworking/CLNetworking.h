//
//  CLNetworking.h
//  CLKit
//
//  Created by chenliang on 03/12/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLNetworking : NSObject

+ (id)sharedInstance;

-(void)getData:(NSString *)url params:( NSDictionary * _Nullable)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock;

-(void)postData:(NSString *)url params:(NSDictionary * _Nullable)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock;

-(void)getJson:(NSString *)url params:(NSDictionary * _Nullable)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock;

-(void)postJson:(NSString *)url params:(NSDictionary * _Nullable)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock;

-(void)upload:(NSString *)url datas:(NSArray *)datas fileName:(NSString *)fileName parameters:(NSDictionary * _Nullable)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock progressBlock:(void(^)(NSProgress *progress))progressBlock;

-(void)download:(NSString *)url fileName:(NSString *)fileName successBlock:(void(^)(NSURL *result))successBlock failBlock:(void(^)(NSError *result))failBlock progressBlock:(void(^)(NSProgress *progress))progressBlock;

-(void)soap:(NSString *)soapXmlString url:(NSString *)url user:(NSDictionary *)user successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock;

@end

NS_ASSUME_NONNULL_END
