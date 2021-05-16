//
//  AnalyseModel.m
//  Trush
//
//  Created by young_jerry on 2021/5/16.
//

#import "AnalyseModel.h"

@implementation DataThirdModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation DataSecondTestModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation AnalyseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
