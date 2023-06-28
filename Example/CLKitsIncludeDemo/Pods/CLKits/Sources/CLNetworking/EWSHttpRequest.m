#import "EWSHttpRequest.h"

@interface EWSHttpRequest () <NSURLSessionDelegate>

@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSString *redirectLocation;
@property (strong, nonatomic) NSDictionary *dict;
@property (copy, nonatomic) HTTPRequestSuccessCompletion successBlock;
@property (copy, nonatomic) HTTPRequestFailureCompletion failureBlock;

@end


@implementation EWSHttpRequest

- (void)ewsHttpRequest:(NSString *)soapXmlString url:(NSString *)url dict:(NSDictionary *)dict success:(HTTPRequestSuccessCompletion)success failure:(HTTPRequestFailureCompletion)failure{
    self.dict = dict;
    self.successBlock = success;
    self.failureBlock = failure;
    self.data = [NSMutableData data];
    
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 20.0;
    
    if (soapXmlString){
        NSString *xmlLength = [NSString stringWithFormat:@"%ld", (unsigned long)soapXmlString.length];
        request.HTTPBody = [soapXmlString dataUsingEncoding:NSUTF8StringEncoding];
        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:xmlLength forHTTPHeaderField:@"Content-Length"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
        NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request];
        [dataTask resume];
    });
}

-(void)ewsHttpRequest:(NSString *)soapXmlString andUrl:(NSString *)url emailBoxInfo:(NSDictionary *)dict receiveResponse:(void (^)(NSURLResponse *response))receiveResponseBlock finishLoading:(void (^)(NSData *data))finishLoadingBlock error:(void (^)(NSError *error))errorBlock{
    
    [self ewsHttpRequest:soapXmlString url:url dict:dict success:^(NSString *redirectLocation, NSData *xmlData) {
        NSString *xmlString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
        NSLog(@"xmlString Data: %@", xmlString);
        finishLoadingBlock(xmlData);
    } failure:^(NSError *error) {
        errorBlock(error);
    }];
    
}

#pragma mark - NSURLSession Delegates

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    NSString *username = [self.dict objectForKey:@"username"];
    NSString *password = [self.dict objectForKey:@"password"];
    if (challenge.previousFailureCount == 0){
        NSURLCredential *credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceForSession];
        
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }else{
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.data appendData:data];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error){
        self.failureBlock ? self.failureBlock(error) : nil;
    }else{
        NSData *data;
        if (self.data){
            data = [NSData dataWithData:self.data];
        }
        self.successBlock ? self.successBlock(self.redirectLocation, data) : nil;
    }
    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler{
    self.redirectLocation = request.URL.absoluteString;
    if (response){
        completionHandler(nil);
    }else{
        completionHandler(request);
    }
}
@end
