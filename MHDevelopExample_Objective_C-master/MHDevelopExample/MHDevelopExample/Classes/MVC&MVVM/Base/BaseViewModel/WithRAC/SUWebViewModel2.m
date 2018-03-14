//
//  SUWebViewModel2.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/19.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM With RAC 开发模式的控制器有WKWebView的所有自定义ViewModel的父类

#import "SUWebViewModel2.h"

@implementation SUWebViewModel2

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [super initWithParams:params];
    if (self) {
        self.request = params[SUViewModelRequestKey];
    }
    return self;
}

@end
