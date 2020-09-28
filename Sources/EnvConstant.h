//
//  EnvConstant.h
//  CLKits
//
//  Created by lion on 2020/5/25.
//  Copyright © 2020 chenl. All rights reserved.
//

#ifndef EnvConstant_h
#define EnvConstant_h

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

#define WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define safeString(obj) (([obj isEqual:[NSNull null]] || (obj == nil) || [@"null" isEqual:obj] || [@"<null>" isEqual:obj] || [@"(null)" isEqual:obj]) ? @"" : ([NSString stringWithFormat:@"%@",obj]))

#define BUTTON_NORMAL_COLOR ([UIColor colorWithRed:38/255.0 green:123/255.0 blue:183/255.0 alpha:1.0])
#define IMAGE_BG_COLOR ([UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1])
#define ONE_SCALE (1/[UIScreen mainScreen].scale)

#endif /* EnvConstant_h */
