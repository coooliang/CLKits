//
//  AmountRuler.h
//  AmountScroller
//
//  Created by Jason on 16/3/17.
//  Copyright © 2016年 DurianGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCEVALUE 10 // 每隔刻度实际长度

@protocol AmountRulerDelegate <NSObject>

-(void)getAmountRulerValue:(CGFloat)rulerValue;

@end

@interface AmountRuler : UIView <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id <AmountRulerDelegate> rulerDelegate;

@property (nonatomic,strong) NSMutableArray *rulerData;
@property (nonatomic,strong) NSString *rulerMinAmount;
@property (nonatomic,strong) NSString *rulerMaxAmount;
@property (nonatomic,strong) NSString *rulerAverage;
@property (nonatomic,assign) CGFloat rulerValue;
@property (nonatomic,assign) BOOL isKeyboardPress;

/**
 *  显示滚轮信息
 *
 *  @param minAmount    最小值
 *  @param maxAmount    最大值
 *  @param average      步径值
 *  @param currentValue 默认值
 *  @param mode         是否最小模式
 */

- (void)showRulerScrollViewWithMinAmount:(NSString *)minAmount maxAmount:(NSString *)maxAmount average:(NSString *)average;

- (void)setScrollToPositionWithAmount:(CGFloat)amount;
@end
