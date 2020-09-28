//
//  AmountScrollView.m
//  AmountScroller
//
//  Created by Jason on 16/3/17.
//  Copyright © 2016年 DurianGroup. All rights reserved.
//

#import "AmountScrollView.h"
#import "EnvConstant.h"

@implementation AmountScrollView

- (void)drawRuler{
    self.rulerData = [NSMutableArray new];
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor colorWithRed:1  green:0.455  blue:0.267 alpha:1].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    self.rulerValue = [self.rulerMinAmount floatValue];
    CGFloat amount;

    for (amount = [self.rulerMaxAmount floatValue]; amount >= [self.rulerMinAmount floatValue]; amount = amount - [self.rulerAverage intValue]) {
        if (fmodf([self.rulerMaxAmount floatValue], [self.rulerAverage intValue]) != 0 && amount == [self.rulerMaxAmount floatValue]) {
            [self.rulerData addObject:self.rulerMaxAmount];
            
            amount = [self.rulerMaxAmount floatValue] - fmodf([self.rulerMaxAmount floatValue], [self.rulerAverage intValue]);
        }else{
            [self.rulerData addObject:[NSString stringWithFormat:@"%d", (int)amount]];
        }
    }
    if (fmodf([self.rulerMinAmount floatValue], [self.rulerAverage intValue]) != 0) {
        [self.rulerData addObject:self.rulerMinAmount];
    }
    
    for (int i = 0; i < [self.rulerData count]; i++) {
        UILabel *rule = [[UILabel alloc] init];
        rule.textColor = [UIColor blackColor];
        rule.text = [self.rulerData objectAtIndex:i];
        
        CGSize titleSize = [rule.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:rule.font.fontName size:rule.font.pointSize]}];
        int value = [[self.rulerData objectAtIndex:i] floatValue];
        if (value%([self.rulerAverage intValue]*10) == 0 || i == 0 || i == [self.rulerData count] - 1) {
            rule.frame = CGRectMake(5 , DISTANCEVALUE * i - titleSize.height / 2, WIDTH/6, titleSize.height);
            [rule adjustsFontSizeToFitWidth];
            [self addSubview:rule];
            CGPathMoveToPoint(pathRef1, NULL, self.rulerWidth - DISTANCEVALUE * 3, DISTANCEVALUE * i);
            CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth, DISTANCEVALUE * i);
        }else{
            CGPathMoveToPoint(pathRef2, NULL, self.rulerWidth - DISTANCEVALUE, DISTANCEVALUE * i);
            CGPathAddLineToPoint(pathRef2, NULL, self.rulerWidth, DISTANCEVALUE * i);
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    UIEdgeInsets edge = UIEdgeInsetsMake(self.rulerHeight / 2.f, 0, self.rulerHeight / 2.f - DISTANCEVALUE, 0);
    self.contentInset = edge;
    self.contentOffset = CGPointMake(0, DISTANCEVALUE * [self.rulerData count] + self.rulerHeight/2);
    
    self.contentSize = CGSizeMake(0, [self.rulerData count] * DISTANCEVALUE);
}

@end
