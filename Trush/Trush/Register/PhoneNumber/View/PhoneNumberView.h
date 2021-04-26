//
//  PhoneNumberView.h
//  Trush
//
//  Created by young_jerry on 2021/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneNumberView : UIView

@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *sureButton;

@end

NS_ASSUME_NONNULL_END
