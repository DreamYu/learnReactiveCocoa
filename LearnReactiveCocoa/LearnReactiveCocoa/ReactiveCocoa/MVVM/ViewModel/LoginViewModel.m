//
//  LoginViewModel.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/3/9.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

//@property (nonatomic, copy) NSString *avatarUrlString;

@end


@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (self.mobilePhone.length > 0) {
            if ([self.mobilePhone isEqualToString:@"111"]) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    return nil;
                }];
            } else {
                return [RACSignal error:[NSError errorWithDomain:@"input" code:1 userInfo:@{@"erorkey":@"输入手机号"}]];
            }
        } else {
            return [RACSignal error:[NSError errorWithDomain:@"input" code:1 userInfo:@{@"erorkey":@"输入手机号"}]];
        }
    }];
    
}

@end
