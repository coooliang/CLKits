//
//  CLCheckBox.m
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "CLCheckBox.h"

@implementation CLCheckBox{
    BOOL _checked;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _checked = false;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(onSelectCheckBox) forControlEvents:UIControlEventTouchDown];
        [self setSelected:NO];
        
    }
    return self;
}
-(void)onSelectCheckBox{
    _checked = !_checked;
    [self setSelected:_checked];
    if (_block) {
        _block(_checked);
    }
}

-(void)setChecked:(BOOL)checked{
    _checked = checked;
}

- (BOOL)checked{
    return _checked;
}

@end
