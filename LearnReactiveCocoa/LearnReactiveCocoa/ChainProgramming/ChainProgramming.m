//
//  ChainProgramming.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/1/22.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "ChainProgramming.h"
#import "NSObject+Caculator.h"


@interface ChainProgramming ()

@end

@implementation ChainProgramming

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger result = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.add(1);
    }];
    NSLog(@"result = %ld", result);
    
}



@end
