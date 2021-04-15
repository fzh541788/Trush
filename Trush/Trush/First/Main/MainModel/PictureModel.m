//
//  PictureModel.m
//  Trush
//
//  Created by young_jerry on 2020/12/30.
//

#import "PictureModel.h"

@implementation PictureModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation ListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation DataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
