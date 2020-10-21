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
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *nid;
@property(nonatomic,strong)NSString *pageOffset;

@property(nonatomic,assign)BOOL isRandom;
@property(nonatomic,assign)BOOL hideToolbar;
@property(nonatomic,assign)BOOL hideField;//只有type等于CLKeyboardTypeScroll时候有效

@property(nonatomic,assign)NSString *minAmount;
@property(nonatomic,assign)NSString * maxAmount;
@property(nonatomic,assign)NSString * average;//平均水平

@end

