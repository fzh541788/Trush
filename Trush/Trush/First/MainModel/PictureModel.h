//
//  PictureModel.h
//  Trush
//
//  Created by young_jerry on 2020/12/30.
//
@protocol DataModel

@end

@protocol ListModel

@end

#import "JSONModel.h"

@interface ListModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@end

@interface DataModel : JSONModel
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSArray<ListModel> *list;

@end

@interface PictureModel :JSONModel

@property (nonatomic, copy) NSString *ret;
@property (nonatomic, copy) NSArray<DataModel> *data;
@property (nonatomic, copy) NSString *qt;

@end
