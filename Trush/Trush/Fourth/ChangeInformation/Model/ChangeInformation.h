//
//  ChangeInformation.h
//  Trush
//
//  Created by young_jerry on 2021/5/8.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeInformation : JSONModel

@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *msg;

@end

NS_ASSUME_NONNULL_END
