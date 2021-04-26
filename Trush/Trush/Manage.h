//
//  Manage.h
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import "PictureModel.h"
#import "TextModel.h"
#import "PhoneNumberModel.h"
#import "LoginModel.h"
#import "RegisterModel.h"
#import "ChangePassWordModel.h"

typedef void (^SucceedBlock)(PictureModel * _Nonnull mainViewNowModel);
typedef void (^TextSucceedBlock)(TextModel * _Nonnull mainViewNowModel);
typedef void (^LoginSucceedBlock)(LoginModel * _Nonnull mainViewNowModel);
typedef void (^RegisterSucceedBlock)(RegisterModel * _Nonnull mainViewNowModel);
typedef void (^PhoneNumberSucceedBlock)(PhoneNumberModel * _Nonnull mainViewNowModel);
typedef void (^ChangePassWordSucceedBlock)(ChangePassWordModel * _Nonnull mainViewNowModel);

typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manage : NSObject<NSURLSessionDelegate>

+ (instancetype)sharedManager;
- (void)loginNetWork:(NSString *)phoneNumber andPassword:(NSString *)password and:(LoginSucceedBlock)loginSucceedBlock error:(ErrorBlock)errorBlock;
- (void)registerNetWork:(NSString *)phone andPassword:(NSString *)password andMsgCode:(NSString *)msgCode and:(RegisterSucceedBlock)registerSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkPicture:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkText:(NSString *)a and:(TextSucceedBlock)textSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkPhoneNumber:(NSString *)a and:(PhoneNumberSucceedBlock)phoneNumberSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfChangePassword:(NSString *)newPassWord and:(ChangePassWordSucceedBlock)changePassWordSucceedBlock error:(ErrorBlock)errorBlock;

//封装一下
@end

NS_ASSUME_NONNULL_END
