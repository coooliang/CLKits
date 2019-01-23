#### this kit just save your time

### CLNetworking:

```
pod 'CLKits/CLNetworking', '~> 1.0.1'
```
```
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
```

### CLPopAnimation:
```
pod 'CLKits/CLPopAnimation', '~> 1.0.1'
```
```

@interface UIView (CLPopAnimation)

-(void)cl_line:(UIColor *)color width:(float)width points:(NSArray *)points;
-(void)circle:(float)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)strokeColor;

-(void)cl_fadeIn;
-(void)cl_fadeIn:(nullable void(^)(void))block;

-(void)cl_fadeOut;
-(void)cl_fadeOut:(nullable void(^)(void))block;

-(void)cl_show;
-(void)cl_show:(nullable void(^)(void))block;

-(void)cl_hide;
-(void)cl_hide:(nullable void(^)(void))block;

-(void)cl_jelly;
-(void)cl_jelly:(nullable void(^)(void))block;

-(void)cl_shake;
-(void)cl_shake:(nullable void(^)(void))block;

-(void)cl_move:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;
-(void)cl_move:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;

-(void)cl_springMove:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;
-(void)cl_springMove:(void(^)(void))block point:(NSValue *)point,... NS_REQUIRES_NIL_TERMINATION;

@end
```