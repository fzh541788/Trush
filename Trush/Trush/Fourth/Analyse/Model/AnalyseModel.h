//
//  AnalyseModel.h
//  Trush
//
//  Created by young_jerry on 2021/5/16.
//
@protocol DataThirdModel

@end

@protocol DataSecondTestModel

@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface DataThirdModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) int recyclable;
@property (nonatomic, assign) int wet;
@property (nonatomic, assign) int harm;
@property (nonatomic, assign) int dry;


@end

@interface DataSecondTestModel : JSONModel

@property (nonatomic, copy) DataThirdModel *gcountl;

@end

@interface AnalyseModel : JSONModel

@property (nonatomic, assign) int status;
@property (nonatomic, copy) DataSecondTestModel *data;

@end

NS_ASSUME_NONNULL_END
