//
//  Manage.h
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import "PictureModel.h"

typedef void (^SucceedBlock)(PictureModel * _Nonnull mainViewNowModel);
typedef void (^ErrorBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface Manage : NSObject

+ (instancetype)sharedManager;
//封装一下
@end

NS_ASSUME_NONNULL_END
