//
//  CLImageButton.m
//  CardsPackage
//
//  Created by chenliang on 2017/6/26.
//  Copyright © 2017年 yypt. All rights reserved.
//

#import "CLImageButton.h"
#import "EnvConstant.h"

@implementation CLImageButton{
    NSDictionary *_dict;
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _cornerRadius = 10;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dict:(NSDictionary *)dict{
    self = [super initWithFrame:frame];
    if (self) {
        _dict = dict;
        UIImageView *iv = [[UIImageView alloc]initWithFrame:self.bounds];
        iv.layer.cornerRadius = _cornerRadius;
        iv.layer.masksToBounds = true;
        NSString *nameStr = safeString([dict objectForKey:@"serviceName"]);
        NSString *url = safeString([dict objectForKey:@"url"]);
        if (nameStr == nil || [@""isEqualToString:nameStr]) {
            [iv setImage:[UIImage imageNamed:safeString([dict objectForKey:@"placeholder"])]];
        } else {
            [iv setImage:[UIImage imageNamed:safeString([dict objectForKey:@"placeholder"])]];
            if ([UIImage imageNamed:nameStr]) {
                [iv setImage:[UIImage imageNamed:nameStr]];
            } else {
                NSURL *photourl = [NSURL URLWithString:url];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];
                [iv setImage:image];
            }
        }
        [self addSubview:iv];
        self.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)imgClick{
    if (_block)_block(_dict);
}

@end
