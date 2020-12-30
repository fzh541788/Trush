//
//  Manage.m
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import "Manage.h"
static Manage *manager = nil;
@implementation Manage

+ (instancetype)sharedManage{
    if (!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [Manage new];
        });
    }
    return manager;
}


@end
