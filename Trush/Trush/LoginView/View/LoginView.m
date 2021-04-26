//
//  LoginView.m
//  Trush
//
//  Created by young_jerry on 2021/4/15.
//

#import "LoginView.h"
#import "Masonry.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(150);
        make.bottom.equalTo(self.mas_top).offset(215);
        make.size.mas_equalTo(CGSizeMake(128,128));
    }];
    
    _enterTextFiled = [[UITextField alloc]init];
    _enterTextFiled.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    //    _enterTextFiled.layer.borderWidth = 0f;
    _enterTextFiled.layer.cornerRadius = 25.0f;
    [self addSubview:_enterTextFiled];
    [_enterTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.bottom.equalTo(self.mas_top).offset(295);
        make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _enterTextFiled.textAlignment = NSTextAlignmentCenter;
    _enterTextFiled.placeholder = @"请输入账号";
    
    _registerTextFiled = [[UITextField alloc]init];
    _registerTextFiled.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    _registerTextFiled.layer.borderColor = [[UIColor blackColor] CGColor];
    //    _registerTextFiled.layer.borderWidth = 0.8f;
    _registerTextFiled.layer.cornerRadius = 25.0f;
    [self addSubview:_registerTextFiled];
    [_registerTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.bottom.equalTo(self.mas_top).offset(365);
        make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _registerTextFiled.textAlignment = NSTextAlignmentCenter;
    _registerTextFiled.placeholder = @"请输入密码";
    _registerTextFiled.secureTextEntry = YES;
    
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_enterButton];
    [_enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(150);
        make.bottom.equalTo(self.mas_top).offset(520);
        make.size.mas_equalTo(CGSizeMake(128,128));
    }];
    [_enterButton setImage:[UIImage imageNamed:@"denglu-3.png"] forState:UIControlStateNormal];
    _enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-150);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(100,100));
    }];
    [_registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_messageButton];
    [_messageButton setTitle:@"手机号登录" forState:UIControlStateNormal];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(100,100));
    }];
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
