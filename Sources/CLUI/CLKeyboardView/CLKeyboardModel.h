//
//  CLKeyboardModel.h
//  CLKits
//
//  Created by lion on 2020/9/28.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CLKeyboardTypeFloat,
    CLKeyboardTypeIDCard,
    CLKeyboardTypePwd,
    CLKeyboardTypeScroll,
} CLKeyboardType;

@interface CLKeyboardModel : NSObject

@property(nonatomic,assign)CLKeyboardType type;

@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *nid;
@property(nonatomic,strong)NSString *pageOffset;

@property(nonatomic,assign)BOOL isRandom;
@property(nonatomic,assign)BOOL hideToolbar;

@property(nonatomic,assign)CGFloat minAmount;
@property(nonatomic,assign)CGFloat maxAmount;
@property(nonatomic,assign)CGFloat average;//平均水平

@end

