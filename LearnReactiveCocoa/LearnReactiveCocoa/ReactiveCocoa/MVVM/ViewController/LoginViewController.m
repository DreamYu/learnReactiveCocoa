//
//  LoginViewController.m
//  LearnReactiveCocoa
//
//  Created by Roy on 2018/3/8.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginView.h"
#import "MainViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verifyTextField;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) LoginView *loginView;

@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    self.loginViewModel = [[LoginViewModel alloc] init];
    self.loginViewModel.avatarUrlString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520601950861&di=dc6560886fd637c703c33e823ff279ff&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F68%2F11%2F35W58PICzbv_1024.jpg";
    [super viewDidLoad];
    [self setupViews];
    [self learnUpdateViewConstraints];
    [self bindViewModel];
     self.loginViewModel.avatarUrlString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520601950860&di=b2bb2e08ddf93f7a813d72973db81e14&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01626057ff29a1a84a0d304f3b5991.jpg%401280w_1l_2o_100sh.jpg";
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.verifyTextField];
    [self.view addSubview:self.loginView];
}

- (void)learnUpdateViewConstraints {
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.height.equalTo(@35);
    }];
    
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(30);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.verifyTextField.mas_bottom).offset(30);
    }];
     
     [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self.view).offset(-50);
         make.left.right.equalTo(self.view);
         make.height.equalTo(@50);
     }];
    
}

- (void)bindViewModel {
    @weakify(self);
    [RACObserve(self.loginViewModel, avatarUrlString) subscribeNext:^(id x) {
        @strongify(self);
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:x]];
    }];
     
    [[self.loginView rac_signalForSelector:@selector(clickBut:)] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"%@", x);
        self.view.backgroundColor = RWRandomColor;
    }];

    
//    RACSignal *phoneNumberSignal = [self.phoneTextField.rac_textSignal subscribeNext:^(id x) {
////        return [RACSignal empty];
//    }];
    
//    RAC(self.loginButton, backgroundColor) = [[self.phoneTextField.rac_textSignal map:^id(id x) {
//        NSString *phoneNumber = x;
//        if (phoneNumber.length > 0) {
//            if ([phoneNumber isEqualToString:@"111"]) {
//                return  [UIColor greenColor];
//            } else {
//                return [UIColor redColor];
//            }
//        } else {
//            return [UIColor grayColor];
//        }
//    }] distinctUntilChanged];
    
    RACSignal *phoneSignal = self.phoneTextField.rac_textSignal;
    RACSignal *verifySignal = self.verifyTextField.rac_textSignal;
    RAC(self.loginButton, backgroundColor) = [[RACSignal combineLatest:@[phoneSignal, verifySignal]
                                                                reduce:^id(NSString *phoneNumber, NSString *verify) {
                                                                    if (phoneNumber.length <= 0 && verify.length <= 0) {
                                                                        return [UIColor grayColor];
                                                                    } else if ([phoneNumber isEqualToString:@"111"] && [verify isEqualToString:@"000"]) {
                                                                        return [UIColor greenColor];
                                                                    } else {
                                                                        return [UIColor redColor];
                                                                    }
                                                                }] distinctUntilChanged];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.loginViewModel.loginCommand execute:nil];
    }];
    
    RAC(self.loginViewModel, mobilePhone) = self.phoneTextField.rac_textSignal;
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        MainViewController *goodsVc = [[MainViewController alloc] init];
        [self.navigationController pushViewController:goodsVc animated:YES];
    }];
    
}

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
    }
    return _loginView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor blueColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor redColor];
    }
    return _headImageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneTextField;
}

- (UITextField *)verifyTextField {
    if (!_verifyTextField) {
        _verifyTextField = [[UITextField alloc] init];
        _verifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _verifyTextField;
}

@end
