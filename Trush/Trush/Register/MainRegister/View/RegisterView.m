//
//  RegisterView.m
//  Trush
//
//  Created by young_jerry on 2021/4/14.
//

#import "RegisterView.h"
#import "Masonry.h"

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    //    self.backgroundColor = [UIColor whiteColor];
    _enterTextField = [[UITextField alloc]init];
    _enterTextField.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    //    _enterTextFiled.layer.borderWidth = 0f;
    _enterTextField.layer.cornerRadius = 25.0f;
    [self addSubview:_enterTextField];
    [_enterTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.bottom.equalTo(self.mas_top).offset(295);
        make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _enterTextField.textAlignment = NSTextAlignmentCenter;
    _enterTextField.placeholder = @"请输入密码";
    
    _registerTextField = [[UITextField alloc]init];
    _registerTextField.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    _registerTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    //    _registerTextFiled.layer.borderWidth = 0.8f;
    _registerTextField.layer.cornerRadius = 25.0f;
    [self addSubview:_registerTextField];
    [_registerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.bottom.equalTo(self.mas_top).offset(365);
        make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _registerTextField.textAlignment = NSTextAlignmentCenter;
    _registerTextField.placeholder = @"请输入验证码";
    _registerTextField.secureTextEntry = YES;
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    _sureButton.titleLabel.tintColor = [UIColor whiteColor];
    _sureButton.backgroundColor = [UIColor colorWithRed:0.694 green:0.937 blue:0.951569 alpha:1];
    _sureButton.layer.cornerRadius = 10.0f;
    [self addSubview:_sureButton];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(_registerTextField.mas_bottom).offset(80);
        make.size.mas_equalTo(CGSizeMake(340, 50));
    }];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backButton setTitle:@"<" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:50];
    _backButton.frame = CGRectMake(20, 80, 50, 50);
    [self addSubview:_backButton];
    
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
