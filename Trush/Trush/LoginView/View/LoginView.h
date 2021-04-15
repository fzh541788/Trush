//
//  LoginView.h
//  Trush
//
//  Created by young_jerry on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UITextField *enterTextFiled;
@property (nonatomic, strong) UITextField *registerTextFiled;

@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *wechatButton;

@end

NS_ASSUME_NONNULL_END
