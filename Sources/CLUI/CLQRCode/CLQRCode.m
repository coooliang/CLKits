//
//  CLQRCode.m
//  CLKits
//
//  Created by lion on 2019/2/27.
//  Copyright © 2019 chenl. All rights reserved.
//

#import "CLQRCode.h"

@implementation CLQRCode

-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue withLogo:(UIImage *)logo logoFrame:(CGRect)logoFrame{
    UIImage *image = [self createQRImageWithContent:content size:size red:red green:green blue:blue withLogo:logo];
    //有 logo 则绘制 logo
//    if (logo != nil) {
//        UIGraphicsBeginImageContext(image.size);
//        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        [logo drawInRect:logoFrame];
//
//        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return resultImage;
//    }else{
//
//    }
    return image;
}

-(UIImage *)createQRImageWithContent:(NSString *)content size:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue withLogo:(UIImage *)logo{
    UIImage *image = [self createQRImageWithContent:content size:size red:red green:green blue:blue];
    //为空则返回
    if (!logo) { return image;}
    UIImage *resultImage = [self imageWithQRImage:image logo:logo logoSize:logo.size];
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

-(UIImage *)imageWithQRImage:(UIImage *)qrImage logo:(UIImage *)logo logoSize:(CGSize)size{
    BOOL opaque = 1.0;
    // 获取当前设备的scale
    CGFloat scale = [UIScreen mainScreen].scale;
    // 创建画布Rect
    CGRect bgRect = CGRectMake(0, 0, size.width, size.height);
    // 头像大小不能大于画布的1/4 （这个大小之内的不会遮挡二维码的有效信息）
    CGFloat logoWidth = (size.width/4);
    CGFloat logoHeight = logoWidth;
    //调用一个新的切割绘图方法(裁切头像图片为圆角，并添加bored   返回一个newimage)
    logo = [self clipCornerRadius:logo withSize:CGSizeMake(logoWidth, logoHeight)];
    // 设置头像的位置信息
    CGPoint position = CGPointMake(size.width/2, size.height/2);
    CGRect logoRect = CGRectMake(position.x-(logoWidth/2), position.y-(logoHeight/2), logoWidth, logoHeight);
    // 设置画布信息
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{// 开启画布
        // 翻转context （画布）
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // 根据 bgRect 用二维码填充视图
        CGContextDrawImage(context, bgRect, qrImage.CGImage);
        //  根据newAvatarImage 填充头像区域
        CGContextDrawImage(context, logoRect, logo.CGImage);
    }CGContextRestoreGState(context);// 提交画布
    // 从画布中提取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 释放画布
    UIGraphicsEndImageContext();
    return image;
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
