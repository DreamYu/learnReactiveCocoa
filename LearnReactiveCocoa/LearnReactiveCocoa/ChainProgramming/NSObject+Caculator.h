//
//  NSObject+Caculator.h
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/1/26.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"

@interface NSObject (Caculator)

+ (NSInteger)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end
