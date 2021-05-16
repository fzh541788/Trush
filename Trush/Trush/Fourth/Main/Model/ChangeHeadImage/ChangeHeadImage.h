//
//  ChangeHeadImage.h
//  Trush
//
//  Created by young_jerry on 2021/5/15.
//
@protocol DataTestModel

@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataTestModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *stage;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *createTime;

@end

@interface ChangeHeadImage : JSONModel

@property (nonatomic, assign) int status;
@property (nonatomic, copy) DataTestModel *data;

@end

NS_ASSUME_NONNULL_END
