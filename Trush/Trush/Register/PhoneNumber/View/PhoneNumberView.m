//
//  PhoneNumberView.m
//  Trush
//
//  Created by young_jerry on 2021/4/18.
//

#import "PhoneNumberView.h"
#import "Masonry.h"

@implementation PhoneNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _titleLabel = [[UILabel alloc]init];
    [self addSubview:_titleLabel];
    [_titleLabel setText:@"用手机号码注册"];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(self.mas_top).offset(160);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    _titleLabel.font = [UIFont systemFontOfSize:30];
    
    _phoneNumberTextField = [[UITextField alloc]init];
    [self addSubview:_phoneNumberTextField];
    [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(self.mas_top).offset(260);
        make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _phoneNumberTextField.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    _phoneNumberTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    _phoneNumberTextField.placeholder = @"输入手机号";
    _phoneNumberTextField.layer.cornerRadius = 10.0f;
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    _sureButton.titleLabel.tintColor = [UIColor whiteColor];
    _sureButton.backgroundColor = [UIColor colorWithRed:0.694 green:0.937 blue:0.951569 alpha:1];
    _sureButton.layer.cornerRadius = 10.0f;
    [self addSubview:_sureButton];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(_phoneNumberTextField.mas_bottom).offset(80);
        make.size.mas_equalTo(CGSizeMake(340, 50));
    }];
    
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backButton setTitle:@"<" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:35];
    _backButton.frame = CGRectMake(10, 50, 50, 50);
    [self addSubview:_backButton];
    
    return self;
}

@end
