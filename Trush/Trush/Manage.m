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
    NSString *url = @"http://116.62.21.180:8088/user/login.do";
    NSDictionary *parameters = @{@"phoneNumber":phoneNumber,
                                 @"password":password};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        LoginModel *model = [[LoginModel alloc] initWithDictionary:responseObject error:nil];
//                NSLog(@"%@", model);
        loginSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)netWorkPhoneNumber:(NSString *)a and:(PhoneNumberSucceedBlock)phoneNumberSucceedBlock error:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/send_code.do";
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

- (void)netWorkOfChangePassword:(NSString *)newPassWord and:(nonnull NSString *)phone and:(nonnull ChangePassWordSucceedBlock)changePassWordSucceedBlock error:(nonnull ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/loginresetpassword.do";
    NSDictionary *parameters = @{@"phone":phone,@"newpassword":newPassWord};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ChangePassWordModel *model = [[ChangePassWordModel alloc] initWithDictionary:responseObject error:nil];
        changePassWordSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)netWorkOfChangeInformation:(NSString *)phone and:(NSString *)name and:(NSString *)msg and:(NSString *)sex and:(NSString *)stage and:(nonnull ChangeInformationSucceedBlock)changeInformationSucceedBlock error:(nonnull ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *url = @"http://116.62.21.180:8088/user/updatemsg.do";
    NSDictionary *parameters = @{@"phone":phone,@"nameNew":name,@"msg":msg,@"sex":sex,@"stage":stage};
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ChangeInformation *model = [[ChangeInformation alloc] initWithDictionary:responseObject error:nil];
        changeInformationSucceedBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@", error);
        errorBlock(error);
    }];
}

- (void)networkofChangeHeadImage:(NSString *)phone and:(NSData *)imageData and:(ChangeHeadImageSucceedBlock)changeHeadImageSucceedBlock error:(ErrorBlock)errorBlock {
     NSString *url = @"http://116.62.21.180:8088/user/change_pic";
     NSDictionary *dictionary = @{@"phone":phone};
     NSLog(@"%@",dictionary);
     AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
     sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencodem", nil];
     sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
     [sessionManager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
     [sessionManager POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [formData appendPartWithFileData:imageData name:@"pic"  fileName:@"headImageTest.jpg" mimeType:@"image/jpg"];       // 上传图片的参数key
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          ChangeHeadImage *model = [[ChangeHeadImage alloc] initWithDictionary:responseObject error:nil];
          changeHeadImageSucceedBlock(model);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          errorBlock(error);
     }];
}

- (void)netWorkOfNumberType:(NSString *)type and:(NSString *)phone {
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     NSString *url = @"http://116.62.21.180:8088/count/get_sort";
     NSDictionary *parameters = @{@"type":type,@"phone":phone,@"n":@1};
     [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"%@",responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败%@", error);
     }];
}

- (void)networkofAnalyse:(NSString *)phone and:(AnalyseModelSucceedBlock)analyseModelSucceedBlock error:(ErrorBlock)errorBlock {
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     NSString *url = @"http://116.62.21.180:8088/user/get_detail";
     NSDictionary *parameters = @{@"phone":phone};
     [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         AnalyseModel *model = [[AnalyseModel alloc] initWithDictionary:responseObject error:nil];
         analyseModelSucceedBlock(model);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败%@", error);
         errorBlock(error);
     }];
}

- (void)netWorkOfNearbyBin:(NSString *)location and:(NearbyBinModelSucceedBlock)nearbyBinModelSucceedBlock error:(ErrorBlock)errorBlock {
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     NSString *url = @"http://116.62.21.180:8088/recycle/get_bin.do";
     NSDictionary *parameters = @{@"location":location};
     [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NearbyBinModel *model = [[NearbyBinModel alloc] initWithDictionary:responseObject error:nil];
         nearbyBinModelSucceedBlock(model);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败%@", error);
         errorBlock(error);
     }];
}

- (void)netWorkOfUpBin:(NSString *)location and:(NSData *)imageData and:(float)longitude and:(float )latitude and:(UpBinModelSucceedBlock)upBinModelSucceedBlock error:(ErrorBlock)errorBlock {
     NSString *url = @"http://116.62.21.180:8088/recycle/upload_bin.do";
     NSDictionary *dictionary = @{@"location":location,@"longitude":[NSString stringWithFormat:@"%f",longitude],@"latitude":[NSString stringWithFormat:@"%f",latitude]};
     NSLog(@"%@",dictionary);
     AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
     sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencodem", nil];
     sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
     [sessionManager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
     [sessionManager POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [formData appendPartWithFileData:imageData name:@"pic"  fileName:@"headImageTest.jpg" mimeType:@"image/jpg"];       // 上传图片的参数key
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          UpBinModel *model = [[UpBinModel alloc] initWithDictionary:responseObject error:nil];
          upBinModelSucceedBlock(model);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          errorBlock(error);
     }];
}
@end
