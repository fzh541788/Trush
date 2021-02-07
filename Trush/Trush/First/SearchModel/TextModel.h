//
//  TextModel.h
//  Trush
//
//  Created by young_jerry on 2021/1/27.
//

@protocol SecondDataModel

@end

@protocol SecondListModel

@end

#import "JSONModel.h"

@interface SecondListModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@end

@interface SecondDataModel : JSONModel
@property (nonatomic, copy) NSArray<SecondListModel> *list;

@end

@interface TextModel :JSONModel

@property (nonatomic, copy) NSString *ret;
@property (nonatomic, copy) SecondDataModel *data;
@property (nonatomic, copy) NSString *qt;

@end
