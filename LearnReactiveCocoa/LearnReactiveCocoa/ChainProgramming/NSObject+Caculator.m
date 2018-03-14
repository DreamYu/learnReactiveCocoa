//
//  NSObject+Caculator.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/1/26.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+ (NSInteger)makeCaculators:(void (^)(CaculatorMaker *))caculatorMaker {
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    caculatorMaker(maker);
    return maker.result;
}

@end
