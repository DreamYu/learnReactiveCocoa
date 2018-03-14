//
//  CaculatorMaker.h
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/1/26.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

typedef CaculatorMaker *(^Add)(int);
typedef CaculatorMaker *(^Sub)(int);
typedef CaculatorMaker *(^Muilt)(int);
typedef CaculatorMaker *(^Divide)(int);



@property (nonatomic, assign) NSInteger result;

@property (nonatomic, copy) Add add;
@property (nonatomic, copy) Sub sub;

//- (CaculatorMaker *(^)(int))add;
//- (CaculatorMaker *(^)(int))sub;
//- (CaculatorMaker *(^)(int))muilt;
//- (CaculatorMaker *(^)(int))divide;

@end
