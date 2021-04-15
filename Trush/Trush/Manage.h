//
//  Manage.h
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import "PictureModel.h"
#import "TextModel.h"
#import "LoginModel.h"

typedef void (^SucceedBlock)(PictureModel * _Nonnull mainViewNowModel);
typedef void (^TextSucceedBlock)(TextModel * _Nonnull mainViewNowModel);
typedef void (^LoginSucceedBlock)(LoginModel * _Nonnull mainViewNowModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manage : NSObject<NSURLSessionDelegate>

+ (instancetype)sharedManager;
- (void)loginNetWork:(NSString *)phoneNumber andPassword:(NSString *)password and:(LoginSucceedBlock)loginSucceedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkPicture:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock;
- (void)NetWorkText:(NSString *)a and:(TextSucceedBlock)textSucceedBlock error:(ErrorBlock)errorBlock;
//封装一下
@end

NS_ASSUME_NONNULL_END
