//
//  CaculatorMaker.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/1/26.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (Add)add {
    return ^CaculatorMaker *(int value) {
        _result += value;
        return self;
    };
}

//- (CaculatorMaker *(^)(int))add {
//    return ^CaculatorMaker *(int) {
//        _result += value;
//        return self;
//    };
//}
//
//- (CaculatorMaker *(^)(int))sub {
//    return ^CaculatorMaker *(int value) {
//        _result -= value;
//        return self;
//    };
//}
//
//- (CaculatorMaker *(^)(int))divide {
//    return ^CaculatorMaker *(int value) {
//        _result /= value;
//        return self;
//    };
//}
//
//- (CaculatorMaker *(^)(int))muilt {
//    return ^CaculatorMaker *(int value) {
//        _result *= value;
//        return self;
//    };
//}

@end
