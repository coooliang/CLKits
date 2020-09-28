//
//  JKSizeFix.h
//  YinYin
//
//  Created by Jason on 15/5/22.
//  Copyright (c) 2015年 China Industrial Bank. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef YinYin_JKSizeFix_h
#define YinYin_JKSizeFix_h

//让iPhone6和Plus的高度部分 自适应
CG_INLINE CGFloat JKFixHeightFloat(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096 * 2 < 1) {
        return height;
    }
    height = height * mainFrme.size.height/1096*2;
    return height;
}

//让iPhone6和Plus的宽度部分 自适应
CG_INLINE CGFloat JKReHeightFloat(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096 * 2 < 1) {
        return height;
    }
    height = height * 1096/(mainFrme.size.height*2);
    return height;
}

CG_INLINE CGFloat JKFixWidthFloat(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096 * 2 < 1) {
        return width;
    }
    width = width * mainFrme.size.width/640 * 2;
    return width;
}

CG_INLINE CGFloat JKReWidthFloat(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096 * 2 < 1) {
        return width;
    }
    width = width * 640/mainFrme.size.width/2;
    return width;
}

CG_INLINE CGRect
JKRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y;
    rect.size.width = JKFixWidthFloat(width);
    rect.size.height = JKFixWidthFloat(height);
    return rect;
}


//设计稿
CG_INLINE CGRect
JKDesignRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    rect.size.width = mainFrme.size.width/375.0 * width;
    rect.size.height = mainFrme.size.height/667.0 * height;
    return rect;
}

CG_INLINE CGFloat JKDesignWidth(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    return mainFrme.size.width/375.0 * width;
}

CG_INLINE CGFloat JKDesignHeight(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    return mainFrme.size.height/667.0 * height;
}

#endif
