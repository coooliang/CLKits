//
//  CLKeyboardView.m
//  CLKits
//
//  Created by lion on 2020/9/28.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "CLKeyboardView.h"
#import "EnvConstant.h"
#import "JKSizeFix.h"

#define kNumFont [UIFont systemFontOfSize:27]
#define textfield_height 40
#define tool_height 44
#define btn_height (JKFixHeightFloat(54))
#define keyboard_height (JKFixHeightFloat(216))

@implementation CLKeyboardView

-(instancetype)initWithModel:(CLKeyboardModel *)model{
    CGRect frame = CGRectMake(0, HEIGHT,WIDTH,keyboard_height);
    self  = [self initWithFrame:frame];
    if (self) {
        if (model.type == CLKeyboardTypeFloat) {
            
        }
    }
    return self;
}

-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = CGRectMake(0, HEIGHT-keyboard_height,WIDTH,keyboard_height);
        self.frame = frame;
    } completion:nil];
}
@end
