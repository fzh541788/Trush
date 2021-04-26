//
//  Manage.m
//  Trush
//
//  Created by young_jerry on 2020/12/27.
//

#import "Manage.h"
#import "AFNetworking.h"

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
- (void)netWorkPicture:(NSString *)a and:(SucceedBlock)succeedBlock error:(ErrorBlock)errorBlock{
    NSString *appcode = @"a2d5ec51ea4f4e628daad0dfab51752e";
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

- (void)netWorkText:(NSString *)a and:(TextSucceedBlock)textSucceedBlock error:(ErrorBlock)errorBlock{
    NSString *appcode = @"a2d5ec51ea4f4e628daad0dfab51752e";
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

- (void)loginNetWork:(NSString *)phoneNumber andPassword:(NSString *)password and:(LoginSucceedBlock)loginSucceedBlock error:(ErrorBlock)errorBlock {
    //    NSLog(@"%@,%@",phoneNumber,password);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8086/user/login.do";
    NSDictionary *parameters = @{@"phoneNumber":phoneNumber,
                                 @"password":password};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        LoginModel *model = [[LoginModel alloc] initWithDictionary:responseObject error:nil];
        //        NSLog(@"%d", model.status);
        loginSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)netWorkPhoneNumber:(NSString *)a and:(PhoneNumberSucceedBlock)phoneNumberSucceedBlock error:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/getmsgcode.do";
    NSDictionary *parameters = @{@"phone":a};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        PhoneNumberModel *model = [[PhoneNumberModel alloc] initWithDictionary:responseObject error:nil];
        phoneNumberSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)registerNetWork:(NSString *)phone andPassword:(NSString *)password andMsgCode:(NSString *)msgCode and:(RegisterSucceedBlock)registerSucceedBlock error:(ErrorBlock)errorBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/register.do";
    NSDictionary *parameters = @{@"phone":phone,
                                 @"password":password,
                                 @"msgCode":msgCode};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        RegisterModel *model = [[RegisterModel alloc] initWithDictionary:responseObject error:nil];
        registerSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)netWorkOfChangePassword:(NSString *)newPassWord and:(ChangePassWordSucceedBlock)changePassWordSucceedBlock error:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/register.do";
    NSDictionary *parameters = @{@"password":newPassWord};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ChangePassWordModel *model = [[ChangePassWordModel alloc] initWithDictionary:responseObject error:nil];
        changePassWordSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}
@end
