//
//  User.h
//  CLKits
//
//  Created by 亮陈 on 2019/1/24.
//  Copyright © 2019年 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : JKDBModel

@property(nonatomic,strong)NSString *userName;

@end

NS_ASSUME_NONNULL_END
