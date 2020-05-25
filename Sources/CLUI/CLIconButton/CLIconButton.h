//
//  CLIconButton.h
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLIconButton : UIButton

@property(nonatomic,strong)NSDictionary *dict;

-(id)initWithFrame:(CGRect)frame imgFloat:(float)imgFloat;

-(id)initWithFrame:(CGRect)frame imgFloat:(float)imgFloat titleFloat:(float)titleFloat;

@end

NS_ASSUME_NONNULL_END
