//
//  XiaoChen.h
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLDBProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XiaoChen : NSObject<CLDBProtocol>

@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
