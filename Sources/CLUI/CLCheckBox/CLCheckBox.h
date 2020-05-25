//
//  CLCheckBox.h
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UICheckBoxBlock)(BOOL checked);

@interface CLCheckBox : UIButton

@property(nonatomic,assign)BOOL checked;

@property(nonatomic,strong)UICheckBoxBlock block;

@end
