//
//  CLIconButton.m
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "CLIconButton.h"

@implementation CLIconButton{
    float _imageFloat;
    float _titleFloat;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _imageFloat = 0.5;
        _titleFloat = 0.5;
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame imgFloat:(float)imgFloat{
    if (self=[super initWithFrame:frame]) {
        _imageFloat = imgFloat;
        _titleFloat = 0.5;
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame imgFloat:(float)imgFloat titleFloat:(float)titleFloat{
    if (self=[super initWithFrame:frame]) {
        _imageFloat = imgFloat;
        _titleFloat = titleFloat;
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.titleLabel.textColor = [UIColor blackColor];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height *_titleFloat;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = contentRect.size.height * _imageFloat;
    return CGRectMake(0, 0, imageW, imageH);
}

@end
