//
//  CLActionSheet.h
//  CLKits
//
//  Created by 陈亮 on 2019/2/1.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLActionSheet : NSObject

-(void)show:(NSArray *)params block:(void(^)(int index))block;

@end

NS_ASSUME_NONNULL_END
