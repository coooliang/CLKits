//
//  AmountRuler.m
//  AmountScroller
//
//  Created by Jason on 16/3/17.
//  Copyright © 2016年 DurianGroup. All rights reserved.
//

#import "AmountRuler.h"

#define INDICATORCOLOR [UIColor colorWithRed:1  green:0.455  blue:0.267 alpha:1].CGColor // 中间指示器颜色

@implementation AmountRuler{
    UITableView *_rulerTableView;
    int _lastAmount;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.isKeyboardPress = NO;
        self.rulerData = [NSMutableArray new];
        _rulerTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _rulerTableView.rowHeight = DISTANCEVALUE;
        _rulerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rulerTableView.delegate = self;
        _rulerTableView.dataSource = self;
        [_rulerTableView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_rulerTableView];
        [self addObserver:self forKeyPath:@"inputEnable" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.rulerData count];
}

- (void)setScrollToPositionWithAmount:(CGFloat)amount{
    if ((int)amount == _lastAmount) {
        return;
    }
    _lastAmount = amount;
    [_rulerTableView setContentOffset:CGPointMake(0, DISTANCEVALUE * [self.rulerData count] - self.bounds.size.height / 2.f - DISTANCEVALUE/2 - round((amount - [self.rulerMinAmount floatValue])/[self.rulerAverage intValue] * DISTANCEVALUE))];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AmountCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        [cell.textLabel setFont:[UIFont systemFontOfSize:DISTANCEVALUE]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIView *shortView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 10, DISTANCEVALUE/2, 10, 1)];
        shortView.tag = 1;
        [shortView setBackgroundColor:[UIColor colorWithRed:0.737  green:0.753  blue:0.780 alpha:1]];
        [cell addSubview:shortView];
        [shortView setHidden:YES];
        
        UIView *longView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20, DISTANCEVALUE/2, 25, 1)];
        longView.tag = 2;
        [longView setBackgroundColor:[UIColor colorWithRed:1  green:0.455  blue:0.267 alpha:1]];
        [cell addSubview:longView];
        [longView setHidden:YES];
    }
    int value = [[self.rulerData objectAtIndex:indexPath.row] floatValue];
    if (value%([self.rulerAverage intValue]*10) == 0 || indexPath.row == 0 || indexPath.row == [self.rulerData count] - 1) {
        [cell.textLabel setText:[self.rulerData objectAtIndex:indexPath.row]];
        [[cell viewWithTag:1] setHidden:YES];
        [[cell viewWithTag:2] setHidden:NO];
    }else{
        [[cell viewWithTag:1] setHidden:NO];
        [[cell viewWithTag:2] setHidden:YES];
    }
    
    return cell;
}

- (void)showRulerScrollViewWithMinAmount:(NSString *)minAmount maxAmount:(NSString *)maxAmount average:(NSString *)average{
    self.rulerMinAmount = minAmount;
    self.rulerMaxAmount = maxAmount;
    self.rulerAverage = average;
    [self addSubview:_rulerTableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2  -1, self.frame.size.width, 2)];
    [line setBackgroundColor:[UIColor colorWithRed:1  green:0.455  blue:0.267 alpha:1]];
    [self addSubview:line];
    
    [self initAmountData];
}

- (void)initAmountData{
    CGFloat amount = [self.rulerMaxAmount floatValue];
    if (fmodf([self.rulerMaxAmount floatValue], [self.rulerAverage intValue]) != 0) {
        [self.rulerData addObject:self.rulerMaxAmount];
        amount = [self.rulerMaxAmount floatValue] - fmodf([self.rulerMaxAmount floatValue], [self.rulerAverage intValue]);
    }
    for (int i = amount; i >= [self.rulerMinAmount floatValue]; i = i - [self.rulerAverage intValue]) {
        [self.rulerData addObject:[NSString stringWithFormat:@"%d", i]];
    }
    if (fmodf([self.rulerMinAmount floatValue], [self.rulerAverage intValue]) != 0) {
        [self.rulerData addObject:self.rulerMinAmount];
    }
    
    [_rulerTableView setContentInset:UIEdgeInsetsMake(self.bounds.size.height / 2.f - DISTANCEVALUE/2, 0, self.bounds.size.height / 2.f - DISTANCEVALUE/2, 0)];
    [_rulerTableView setContentOffset:CGPointMake(0, DISTANCEVALUE * [self.rulerData count] - self.bounds.size.height / 2.f - DISTANCEVALUE/2 )];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isKeyboardPress) {
        self.isKeyboardPress = NO;
        return;
    }
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.frame.size.height/2 - DISTANCEVALUE/2;
    if ((int)roundf(offSetY / DISTANCEVALUE) < 0 || (int)roundf(offSetY / DISTANCEVALUE) > [[self rulerData] count] - 1) {
        return;
    }
    
    CGFloat ruleValue = [[[self rulerData] objectAtIndex:(int)roundf(offSetY / DISTANCEVALUE)] floatValue];
    if (ruleValue < [[self rulerMinAmount] floatValue]) {
        return;
    } else if (ruleValue > [[self rulerMaxAmount] floatValue]) {
        return;
    }
    if (self.rulerDelegate) {
        [self setRulerValue:ruleValue];
        [self.rulerDelegate getAmountRulerValue:self.rulerValue];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.frame.size.height/2 - DISTANCEVALUE/2;
    CGFloat value = roundf(offSetY/DISTANCEVALUE);
    CGFloat offY = value * DISTANCEVALUE - scrollView.frame.size.height/2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(0, offY + DISTANCEVALUE/2);
    }];
}

- (void)dealloc{
    @try {
        [self removeObserver:self forKeyPath:@"inputEnable"];
    } @catch (NSException *exception) {
        NSLog(@"exception = %@",exception);
    }
}

@end
