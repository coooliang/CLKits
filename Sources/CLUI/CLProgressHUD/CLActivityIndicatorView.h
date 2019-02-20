//
//  ActivityIndicatorView.h
//  YinYin
//
//  Created by  on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CLActivityIndicatorView : UIView


-(id)initWithFrame:(CGRect)frame;
-(void)stopAnimat;
-(void)startAnimat;

@property(nonatomic,assign)NSTimeInterval timeOutSecond;
@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UIImageView *animatedCircleImageView;
@end
