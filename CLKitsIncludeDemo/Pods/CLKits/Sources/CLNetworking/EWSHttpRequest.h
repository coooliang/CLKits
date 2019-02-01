#import <Foundation/Foundation.h>

typedef void(^HTTPRequestSuccessCompletion)(NSString *redirectLocation, NSData *xmlData);
typedef void(^HTTPRequestFailureCompletion)(NSError *error);
typedef void(^HTTPRecieveDataBlock)(NSData *data);

@interface EWSHttpRequest : NSObject

-(void)ewsHttpRequest:(NSString *)soapXmlString url:(NSString *)url dict:(NSDictionary *)dict success:(HTTPRequestSuccessCompletion)success failure:(HTTPRequestFailureCompletion)failure;

@end
