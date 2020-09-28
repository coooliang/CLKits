//
//  AmountScrollView.h
//  AmountScroller
//
//  Created by Jason on 16/3/17.
//  Copyright © 2016年 DurianGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCEVALUE 8.f // 每隔刻度实际长度8个点

@interface AmountScrollView : UIScrollView

@property (nonatomic) NSUInteger rulerWidth;
@property (nonatomic) NSUInteger rulerHeight;

@property (nonatomic) NSMutableArray *rulerData;
@property (nonatomic) NSString *rulerMinAmount;
@property (nonatomic) NSString *rulerMaxAmount;
@property (nonatomic) NSString *rulerAverage;
@property (nonatomic) CGFloat rulerValue;
@property (nonatomic) BOOL mode;

- (void)drawRuler;

@end
