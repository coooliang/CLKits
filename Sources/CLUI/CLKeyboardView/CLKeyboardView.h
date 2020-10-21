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
#import "CLKeyboardButton.h"

typedef void (^CloseBlock)(void);

@protocol CLKeyboardViewDelegate <NSObject>

- (void)CLKeyboardInput:(NSString *)text;
- (void)CLKeyboardBackspace;
- (void)CLKeyboardOtherButton:(CLKeyboardButton *)sender;

@end

@interface CLKeyboardView : UIView

-(instancetype)initWithModel:(CLKeyboardModel *)model;
-(void)show;
-(void)hide;

@property(nonatomic,strong) CLKeyboardModel *model;

@property(nonatomic,assign) id<CLKeyboardViewDelegate> delegate;

@property(nonatomic,assign)CloseBlock _closeBlock;

@end

