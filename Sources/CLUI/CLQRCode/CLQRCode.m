//
//  CLQRCode.m
//  CLKits
//
//  Created by lion on 2019/2/27.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLQRCode.h"

@implementation CLQRCode

#pragma mark - 获取条形码
-(UIImage*)createBarImageWithContent:(NSString *)content{
    // 创建条形码
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 将CIImage转换成UIImage，并放大显示
    UIImage* image =  [UIImage imageWithCIImage:outputImage scale:0 orientation:UIImageOrientationUp];
    return image;
}

-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size color:(UIColor *)color withLogo:(UIImage *)logo logoSize:(CGFloat)logoSize{
    if (color == nil) {
        color = [UIColor blackColor];
    }
    NSArray *components = [self changeUIColorToRGB:color];
    
    UIImage *image = [self createQRImageWithContent:content size:size red:[components[0]floatValue] green:[components[1]floatValue] blue:[components[2]floatValue]];
    //有 logo 则绘制 logo
    if (logo != nil){
        if (logoSize == 0) {
            logoSize = logo.size.width;
        }
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);// 开始图形上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();// 获得图形上下文

        CGRect rect = CGRectMake((image.size.width-logoSize)/2.0, (image.size.height-logoSize)/2.0, logoSize,logoSize);
        CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5].CGPath);
        CGContextClip(ctx);
        [logo drawInRect:rect];
        UIImage *logoImage = UIGraphicsGetImageFromCurrentImageContext();// 从上下文上获取剪裁后的照片
        UIGraphicsEndImageContext();// 关闭上下文
        image = [self drawImage:image withBadge:logoImage];
    }
    return image;
}


//将UIColor转换为RGB值
- (NSArray *)changeUIColorToRGB:(UIColor *)color{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}
    
-(UIImage *)drawImage:(UIImage*)profileImage withBadge:(UIImage *)badge{
    UIGraphicsBeginImageContextWithOptions(profileImage.size, NO, 0.0f);
    [profileImage drawInRect:CGRectMake(0, 0, profileImage.size.width, profileImage.size.height)];
    [badge drawInRect:CGRectMake(0, profileImage.size.height - badge.size.height, badge.size.width, badge.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//改变二维码颜色
-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    UIImage *image = [self createQRImageWithContent:content size:size];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xffffff00) < 0xd0d0d000) {
            //将黑点变成自定义的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            //将白点变成透明色，如不需要变透明则屏蔽
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    //取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight,ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    return resultImage;
}

-(UIImage *)createQRImageWithContent:(NSString *)string size:(CGSize)size{
    // 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认属性，因为滤镜有可能保存了上一次的属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 设置滤镜,传入Data，
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    
    // 生成二维码
    CIImage *image = filter.outputImage;
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.width / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    //创建DeviceGray灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    //创建bitmap
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage: scaledImage];
}

#pragma mark -
-(UIImage *)clipCornerRadius:(UIImage *)image withSize:(CGSize) size{
    
    // 白色border的宽度
    CGFloat outerWidth = size.width/15.0;
    // 黑色border的宽度
    CGFloat innerWidth = outerWidth/10.0;
    // 设置圆角
    CGFloat corenerRadius = size.width/5.0;
    // 为context创建一个区域
    CGRect areaRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *areaPath = [UIBezierPath bezierPathWithRoundedRect:areaRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corenerRadius, corenerRadius)];
    // 因为UIBezierpath划线是双向扩展的 初始位置就不会是（0，0）
    // origin position
    CGFloat outerOrigin = outerWidth/2.0;
    CGFloat innerOrigin = innerWidth/2.0 + outerOrigin/1.2;
    CGRect outerRect = CGRectInset(areaRect, outerOrigin, outerOrigin);
    CGRect innerRect = CGRectInset(outerRect, innerOrigin, innerOrigin);
    //  外层path
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:outerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(outerRect.size.width/5.0, outerRect.size.width/5.0)];
    //  内层path
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithRoundedRect:innerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(innerRect.size.width/5.0, innerRect.size.width/5.0)];
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        // 翻转context
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // 1.先对画布进行裁切
        CGContextAddPath(context, areaPath.CGPath);
        CGContextClip(context);
        // 2.填充背景颜色
        CGContextAddPath(context, areaPath.CGPath);
        UIColor *fillColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
        // 3.执行绘制logo
        CGContextDrawImage(context, innerRect, image.CGImage);
        // 4.添加并绘制白色边框
        CGContextAddPath(context, outerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, outerWidth);
        CGContextStrokePath(context);
        // 5.白色边框的基础上进行绘制黑色分割线
        CGContextAddPath(context, innerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, innerWidth);
        CGContextStrokePath(context);
    }CGContextRestoreGState(context);
    UIImage *radiusImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return radiusImage;
}



void ProviderReleaseData(void * info, const void * data, size_t size) {
    free((void *)data);
}

/*
 -(UIImage *)createQRImageWithContent2:(NSString *)string size:(CGSize)size{
     // 实例化二维码滤镜
     CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
     // 恢复滤镜默认属性，因为滤镜有可能保存了上一次的属性
     [filter setDefaults];
     // 将字符串转换成NSData
     NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
     // 设置滤镜,传入Data，
     [filter setValue:data forKey:@"inputMessage"];
     [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
 
     //上色
     UIColor *onColor = [UIColor blackColor];
     UIColor *offColor = [UIColor whiteColor];
     CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
     keysAndValues:
     @"inputImage",filter.outputImage,
     @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
     @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
     nil];
 
     CIImage *qrImage = colorFilter.outputImage;
 
     //绘制
     CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
     UIGraphicsBeginImageContext(size);
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetInterpolationQuality(context, kCGInterpolationNone);
     CGContextScaleCTM(context, 1.0, -1.0);
     CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
     UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
 
     CGImageRelease(cgImage);
 
     return codeImage;
 }
 */

@end
