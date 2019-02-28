//
//  CLQRCode.h
//  CLKits
//
//  Created by lion on 2019/2/27.
//  Copyright © 2019 chenl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CLQRCode : NSObject

-(UIImage*)createBarImageWithContent:(NSString *)content;

-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size color:(UIColor *)color withLogo:(UIImage *)logo logoSize:(CGFloat)logoSize;

@end

