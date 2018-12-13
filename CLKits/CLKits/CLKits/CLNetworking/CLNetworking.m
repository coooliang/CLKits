//
//  CLNetworking.m
//  CLKit
//
//  Created by chenliang on 03/12/2018.
//  Copyright © 2018 chenl. All rights reserved.
//

#import "CLNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import "EWSHttpRequest.h"

#define CLNetworkingTimeoutInterval 20

typedef NS_ENUM(NSInteger, CLNetworkingRequestType){
    CLNetworkingGet,
    CLNetworkingPost
};

@implementation CLNetworking

+ (id)sharedInstance{
    static CLNetworking *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)getData:(NSString *)url params:(NSDictionary *)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    [self connect:url params:params type:CLNetworkingGet successBlock:successBlock failBlock:failBlock];
}
-(void)postData:(NSString *)url params:(NSDictionary *)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    [self connect:url params:params type:CLNetworkingPost successBlock:successBlock failBlock:failBlock];
}

-(void)getJson:(NSString *)url params:(NSDictionary *)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    [self connect:url params:params type:CLNetworkingGet successBlock:^(id result) {
        if(successBlock)successBlock([self changeJson:result]);
    } failBlock:failBlock];
}
-(void)postJson:(NSString *)url params:(NSDictionary *)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    [self connect:url params:params type:CLNetworkingPost successBlock:^(id result) {
        if(successBlock)successBlock([self changeJson:result]);
    } failBlock:failBlock];
}

-(void)connect:(NSString *)url params:(NSDictionary *)params type:(CLNetworkingRequestType)type successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    AFHTTPSessionManager *manager = [self manager];
    if (type == CLNetworkingGet) {
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(successBlock)successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failBlock)failBlock(error);
        }];
    }else{
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(successBlock)successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failBlock)failBlock(error);
        }];
    }
}
-(AFHTTPSessionManager *)manager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = CLNetworkingTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return manager;
}

-(NSString *)changeJson:(NSData *)data{
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *restring = [string stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
    NSData* dd = [restring dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:dd options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        return nil;
    }
    return result;
}


/**
 上传

 @param url 地址
 @param datas 数据
 @param fileName 文件
 @param params 参eovt
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param progressBlock 进度
 */
-(void)upload:(NSString *)url datas:(NSArray *)datas fileName:(NSString *)fileName parameters:(NSDictionary *)params successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock progressBlock:(void(^)(NSProgress *progress))progressBlock{
    NSError *error = NULL;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *fn = [NSString stringWithFormat:@"%@%lu",fileName,idx];
            [formData appendPartWithFileData:obj name:fn fileName:fn mimeType:@"multipart/form-data"];
        }];
    } error:&error];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progressBlock)progressBlock(uploadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if(failBlock)failBlock(error);
        }else{
            if(successBlock)successBlock(responseObject);
        }
    }];
    [uploadTask resume];
}

/**
 下载

 @param url 请求地址
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param progressBlock 进度
 */
-(void)download:(NSString *)url fileName:(NSString *)fileName successBlock:(void(^)(NSURL *result))successBlock failBlock:(void(^)(NSError *result))failBlock progressBlock:(void(^)(NSProgress *progress))progressBlock{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if(progressBlock)progressBlock(downloadProgress);
    }  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:fileName];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            if(failBlock)failBlock(error);
        }else{
            if(successBlock)successBlock(filePath);
        }
    }];
    [downloadTask resume];
}

/**
 soap post

 @param soapXmlString soap xml
 @param url server url
 @param user keys:username,password
 @param successBlock success callback
 @param failBlock fail callback
 */
-(void)soap:(NSString *)soapXmlString url:(NSString *)url user:(NSDictionary *)user successBlock:(void(^)(id result))successBlock failBlock:(void(^)(id result))failBlock{
    EWSHttpRequest *request = [[EWSHttpRequest alloc]init];
    [request ewsHttpRequest:soapXmlString url:url dict:user success:^(NSString *redirectLocation, NSData *xmlData) {
        if(successBlock)successBlock(xmlData);
    } failure:^(NSError *error) {
        if(failBlock)failBlock(error);
    }];
}

-(NSString *)mimeType:(NSString *)name{
    NSString *suffix = [name pathExtension];
    if ([@"pdf"isEqualToString:suffix]) {
        return @"application/pdf";
    }else if ([@"doc"isEqualToString:suffix]) {
        return @"application/msword";
    }else if ([@"docx"isEqualToString:suffix]) {
        return @"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    }else if ([@"avi"isEqualToString:suffix]) {
        return @"video/x-msvideo";
    }else if ([@"csv"isEqualToString:suffix]) {
        return @"text/csv";
    }else if ([@"jpg"isEqualToString:suffix] || [@"jpeg"isEqualToString:suffix]) {
        return @"image/jpeg";
    }else if ([@"png"isEqualToString:suffix]) {
        return @"image/png";
    }else if ([@"ppt"isEqualToString:suffix]) {
        return @"application/vnd.ms-powerpoint";
    }else if ([@"pptx"isEqualToString:suffix]) {
        return @"application/vnd.openxmlformats-officedocument.presentationml.presentation";
    }else if ([@"xls"isEqualToString:suffix]) {
        return @"application/vnd.ms-excel";
    }else if ([@"xlsx"isEqualToString:suffix]) {
        return @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    }else if ([@"xml"isEqualToString:suffix]) {
        return @"application/xml";
    }else if ([@"htm"isEqualToString:suffix] || [@"html"isEqualToString:suffix]) {
        return @"text/html";
    }else if ([@"gif"isEqualToString:suffix]) {
        return @"image/gif";
    }
    return @"application/pdf";
}

//获取当前时间
- (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYYMMdd-hhmm"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

@end
