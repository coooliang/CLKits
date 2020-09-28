//
//  CLKeyboardView.h
//  CLKits
//
//  Created by lion on 2020/9/28.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmountRuler.h"
#import "CLKeyboardModel.h"

@protocol CLKeyboardViewDelegate <NSObject>

- (void)CLKeyboardInput:(NSString *)text;
- (void)CLKeyboardBackspace;
- (void)CLKeyboardOtherButton:(NSString *)text;

@end

@interface CLKeyboardView : UIView

-(instancetype)initWithModel:(CLKeyboardModel *)model;

@property(nonatomic,assign) id<CLKeyboardViewDelegate> delegate;
@property(nonatomic,strong) UITextField *numberFiled;
@property(nonatomic,strong) AmountRuler *amountRuler;
@end
