//
//  CLCircleProgress.h
//  CLKits
//
//  Created by 陈亮 on 2018/12/30.
//  Copyright © 2018 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLCircleProgress : UIView

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat percent;//0-10
@property(nonatomic,strong)UIColor *backgroundColor;
@property(nonatomic,strong)UIColor *circleColor;

@property(nonatomic,assign)NSTimeInterval duration;

-(void)show;

@end

NS_ASSUME_NONNULL_END
