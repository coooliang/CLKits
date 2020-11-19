//
//  UITextField+ExtentRange.h
//  YinYin
//
//  Created by Jason on 14-9-22.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;

@end
