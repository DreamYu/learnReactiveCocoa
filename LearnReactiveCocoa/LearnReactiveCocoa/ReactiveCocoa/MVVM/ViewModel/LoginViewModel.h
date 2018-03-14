//
//  LoginViewModel.h
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/3/9.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString *avatarUrlString;

/// 手机号
@property (nonatomic, copy) NSString *mobilePhone;

@property (nonatomic, strong) RACCommand *loginCommand;

@end
