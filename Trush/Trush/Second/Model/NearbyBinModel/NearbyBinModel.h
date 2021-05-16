//
//  NearbyBinModel.h
//  Trush
//
//  Created by young_jerry on 2021/5/16.
//

@protocol DataNearbyBinModel

@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataNearbyBinModel : JSONModel

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *picture;

@end

@interface NearbyBinModel : JSONModel

@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSArray<DataNearbyBinModel>* data;

@end

NS_ASSUME_NONNULL_END
