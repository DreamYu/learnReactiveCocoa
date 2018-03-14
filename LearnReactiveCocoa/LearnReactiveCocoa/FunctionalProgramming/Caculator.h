//
//  Caculator.h
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/2/2.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, assign) BOOL isEqule;

//- (Caculator *)caculator:(NSInteger(^)(NSInteger result))caculator;
//
//- (Caculator *)equle:(BOOL(^)(NSInteger result))operation;

@end
