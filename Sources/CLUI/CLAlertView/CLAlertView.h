//
//  CLAlertView.h
//  CLKits
//
//  Created by lion on 2019/2/22.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CLAlertView : UIViewController

-(void)show:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons block:(void(^)(int index))block;;

@property(nonatomic,assign)BOOL closed;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIColor *color;

@end

