//
//  CLQRCode.h
//  CLKits
//
//  Created by lion on 2019/2/27.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLQRCode : NSObject

-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue withLogo:(UIImage *)logo logoFrame:(CGRect)logoFrame;

@end

NS_ASSUME_NONNULL_END
