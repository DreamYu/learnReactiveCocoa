//
//  WTReactiveCocoa.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/3/8.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "WTReactiveCocoa.h"
#import <ReactiveCocoa/ReactiveCocoa-umbrella.h>
#import "LoginViewController.h"

@interface WTReactiveCocoa ()

@end

@implementation WTReactiveCocoa

- (void)dealloc {
    
}

- (void)viewDidLoad {
    ///https://www.jianshu.com/p/e99cb4310482 代码出处
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test6];
}

#pragma mark - 基础使用
- (void)test8 {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    textField.borderStyle  = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    
    /// 输出x
    [textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"***%@", x);
        NSLog(@"***%@", x);
    }];
    
    /// 长度大于3的输出
    //    [[textField.rac_textSignal filter:^BOOL(NSString *value) {
    //        NSLog(@"bool__%@", value);
    //        return value.length > 3;
    //    }] subscribeNext:^(id x) {
    //        NSLog(@"nslog__%@", x);
    //    }];
    
    //    [[[textField.rac_textSignal map:^id(NSString *value) {
    //        return @(value.length); /// 用map把string转换成NSNumber
    //    }] filter:^BOOL(NSNumber *value) {
    //        return value.integerValue > 3;
    //    }] subscribeNext:^(id x) {
    //        NSLog(@"***%@", x);
    //    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}

#pragma mark - 概念性使用
- (void)test7 {
    RACSignal *signal = [@"A BCDE F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}

- (void)test6 {
    UIButton *reactiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reactiveButton.frame = CGRectMake(100, 100, 100, 50);
    reactiveButton.backgroundColor = [UIColor blueColor];
    [reactiveButton setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:reactiveButton];
    reactiveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *input) {
        NSLog(@"%@", input.currentTitle);
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return [RACSignal empty];
    }];
    
}

- (void)test5 {
    RACReplaySubject *repalySubject = [RACReplaySubject subject];
    
    /// 发送信号
    [repalySubject sendNext:@"1"];
    [repalySubject sendNext:@"2"];
    
    /// 订阅信号
    [repalySubject subscribeNext:^(id x) {
        NSLog(@"FirstSubscribeNext = %@",x);
    }];
    
    [repalySubject subscribeNext:^(id x) {
        NSLog(@"SecondSubscribeNext = %@",x);
    }];
}

- (void)test4 {
    RACSubject *subject = [RACSubject subject];
    
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"FirstSubscribeNext = %@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"SecondSubscribeNext = %@",x);
    }];
    /// 发送信号
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    
}

- (void)test3 {
    RACSignal *repeatSigal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] repeat];
    //    [repeatSigal takeUntil:[self rac_willDeallocSignal]];
    [repeatSigal rac_deallocDisposable];
    
    [repeatSigal subscribeNext:^(id x) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSLog(@"%@",[formatter stringFromDate:x]);
    }];
    
    //    [repeatSigal rac_deallocDisposable];
    
}

- (void)changeSelf {
    self.view.alpha = arc4random() % 10 / 10.f;
}


- (void)test2 {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSelf) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //#pragma clang diagnostic push
    //#pragma clang diagnostic ignored"-Wreceiver-is-weak"
    RACSignal *userNameSignal = [RACObserve(self.view, alpha) distinctUntilChanged];
    //#pragma clang diagnostic pop
    
    RAC(self.view, backgroundColor) = [[userNameSignal map:^id(id value) {
        return [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.];
    }] distinctUntilChanged];
    
}

- (void)test1 {
    __block NSInteger aNumber = 0;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        aNumber ++;
        [subscriber sendNext:@(aNumber)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"one %@", x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"two %@", x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"three %@", x);
    }];
    
    [signal subscribeCompleted:^{
        NSLog(@"Completed");
    }];
    
}




@end
