//
//  Manage.m
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import "Manage.h"
static Manage *manager = nil;
@implementation Manage

+ (instancetype)sharedManager{
    if (!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [Manage new];
        });
    }
    return manager;
}
- (void)NetWorkPicture:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *appcode = @"020f29d085c94396a9d97ce258b8b2b4";
    NSString *host = @"https://recover.market.alicloudapi.com";
    NSString *path = @"/recover";
    NSString *method = @"POST";
    NSString *url = [NSString stringWithFormat:@"%@%@", host, path];
    
    NSString *bodys = [NSString stringWithFormat:@"img=data:image/jpeg;base64,%@",a];//
//    bodys = [self urlEncodeStr:bodys];
//    NSLog(@"%@",bodys);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];

    request.HTTPMethod  =  method;

    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];

    [request addValue: @"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];

    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];

    [request setHTTPBody: data];

    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"网络请求失败\n %@",error);
        } else {
            PictureModel *country = [[PictureModel alloc]initWithData:body error:nil];
            NSLog(@"%@",country.ret);
            succeedBlock(country);
        }
}];
    [task resume];
}

- (void)NetWorkText:(NSString *)a and:(TextSucceedBlock)textSucceedBlock error:(ErrorBlock)errorBlock{
    NSString *appcode = @"020f29d085c94396a9d97ce258b8b2b4";
    NSString *host = @"https://recover2.market.alicloudapi.com";
    NSString *path = @"/recover_word";
    NSString *method = @"GET";
    NSString *querys = @"?name=";
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",  host,  path , querys, a];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"网络请求失败\n %@",error);
        } else {
//                NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
//               打印应答中的body
//               NSLog(@"Response body: %@" , bodyString);
            TextModel *country = [[TextModel alloc] initWithData:body error:nil];
//            NSLog(@"country：%@",country.data);
            textSucceedBlock(country);
        }
        }];
    
    [task resume];
}

@end
