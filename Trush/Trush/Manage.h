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
#import "ChangeInformation.h"
#import "ChangeHeadImage.h"
#import "AnalyseModel.h"
#import "NearbyBinModel.h"
#import "UpBinModel.h"

typedef void (^SucceedBlock)(PictureModel * _Nonnull mainViewNowModel);
typedef void (^TextSucceedBlock)(TextModel * _Nonnull mainViewNowModel);
typedef void (^LoginSucceedBlock)(LoginModel * _Nonnull mainViewNowModel);
typedef void (^RegisterSucceedBlock)(RegisterModel * _Nonnull mainViewNowModel);
typedef void (^ChangeHeadImageSucceedBlock)(ChangeHeadImage * _Nonnull mainViewNowModel);
typedef void (^PhoneNumberSucceedBlock)(PhoneNumberModel * _Nonnull mainViewNowModel);
typedef void (^ChangePassWordSucceedBlock)(ChangePassWordModel * _Nonnull mainViewNowModel);
typedef void (^ChangeInformationSucceedBlock)(ChangeInformation * _Nonnull mainViewNowModel);
typedef void (^AnalyseModelSucceedBlock)(AnalyseModel * _Nonnull mainViewNowModel);
typedef void (^NearbyBinModelSucceedBlock)(NearbyBinModel * _Nonnull mainViewNowModel);
typedef void (^UpBinModelSucceedBlock)(UpBinModel * _Nonnull mainViewNowModel);

typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manage : NSObject<NSURLSessionDelegate>

+ (instancetype)sharedManager;
- (void)loginNetWork:(NSString *)phoneNumber andPassword:(NSString *)password and:(LoginSucceedBlock)loginSucceedBlock error:(ErrorBlock)errorBlock;
- (void)registerNetWork:(NSString *)phone andPassword:(NSString *)password andMsgCode:(NSString *)msgCode and:(RegisterSucceedBlock)registerSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkPicture:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkText:(NSString *)a and:(TextSucceedBlock)textSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkPhoneNumber:(NSString *)a and:(PhoneNumberSucceedBlock)phoneNumberSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfChangePassword:(NSString *)newPassWord and:(NSString *)phone and:(ChangePassWordSucceedBlock)changePassWordSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfChangeInformation:(NSString *)phone and:(NSString *)name and:(NSString *)msg and:(NSString *)sex and:(NSString *)stage and:(ChangeInformationSucceedBlock)changeInformationSucceedBlock error:(ErrorBlock)errorBlock;
- (void)networkofChangeHeadImage:(NSString *)phone and:(NSData *)imageData and:(ChangeHeadImageSucceedBlock)changeHeadImageSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfNumberType:(NSString *)type and:(NSString *)phone;
- (void)networkofAnalyse:(NSString *)phone and:(AnalyseModelSucceedBlock)analyseModelSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfNearbyBin:(NSString *)location and:(NearbyBinModelSucceedBlock)nearbyBinModelSucceedBlock error:(ErrorBlock)errorBlock;
- (void)netWorkOfUpBin:(NSString *)location and:(NSData *)imageData and:(float)longitude and:(float) latitude and:(UpBinModelSucceedBlock)upBinModelSucceedBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
