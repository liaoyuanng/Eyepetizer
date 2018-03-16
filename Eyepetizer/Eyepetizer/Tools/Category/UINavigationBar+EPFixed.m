//
//  UINavigationBar+EPFixed.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/16.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "UINavigationBar+EPFixed.h"
#import <objc/runtime.h>

@implementation UINavigationBar (EPFixed)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(ep_layoutSubviews));
    BOOL result = class_addMethod(self, @selector(layoutSubviews), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (result) {
        class_replaceMethod(self, @selector(ep_layoutSubviews), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)ep_layoutSubviews {
    [self ep_layoutSubviews];
//    if (@available(iOS 11.0, *)) {
//        self.layoutMargins = UIEdgeInsetsZero;
////        CGFloat space = sx_tempFixSpace !=0 ? sx_tempFixSpace : sx_defaultFixSpace;
//        for (UIView *subview in self.subviews) {
//            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
//                subview.layoutMargins = UIEdgeInsetsMake(0, -15, 0, 0);//可修正iOS11之后的偏移
//                break;
//            }
//        }
//    }
}

@end
