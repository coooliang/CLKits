//
//  CLImageButton.h
//  CardsPackage
//
//  Created by chenliang on 2017/6/26.
//  Copyright © 2017年 yypt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(NSDictionary *data);

@interface CLImageButton : UIView

//def 10
@property(nonatomic,assign)float cornerRadius;


/*
 iv.block = ^(NSDictionary * _Nonnull data) {
     NSLog(@"click");
 };
 */
@property(copy,nonatomic)ClickBlock block;

- (instancetype)initWithFrame:(CGRect)frame dict:(NSDictionary *)dict;


@end

