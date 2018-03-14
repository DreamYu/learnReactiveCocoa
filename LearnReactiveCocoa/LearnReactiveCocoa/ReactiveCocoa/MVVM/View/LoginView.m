//
//  LoginView.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/3/12.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginView

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
        [self learnUpdateViewConstraints];
        [self viewSignal];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.loginButton];
}

- (void)learnUpdateViewConstraints {
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)viewSignal {
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self clickBut:x];
    }];
}

- (void)clickBut:(UIButton *)sender {
    sender.backgroundColor = RWRandomColor;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor blueColor];
        [_loginButton setTitle:@"变色" forState:UIControlStateNormal];
    }
    return _loginButton;
}

@end
