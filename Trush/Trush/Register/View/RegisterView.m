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
    
    _returnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _returnButton.frame = CGRectMake(180, 500, 50, 50);
    [_returnButton setTitle:@"确认" forState:UIControlStateNormal];
    _returnButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_returnButton];
    
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
