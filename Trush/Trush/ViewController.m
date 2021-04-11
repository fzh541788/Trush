//
//  ViewController.m
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import "ViewController.h"
#import "RecognitionViewController.h"
#import "MapViewController.h"
#import "GuideViewController.h"
#import "MyViewController.h"
#import "Masonry.h"
#import "RegisterViewController.h"
//把数据库的操作全部转化成 后台的操作
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"NameAndPass.sqlite"];
    self.path = fileName;
    
    //加个判断数据库是否存在，即是否添加过对象 如果没有的话 弹出下面界面 否则进入界面
    _logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(150);
            make.bottom.equalTo(self.view.mas_top).offset(215);
            make.size.mas_equalTo(CGSizeMake(128,128));
    }];
    
    _enterTextFiled = [[UITextField alloc]init];
    _enterTextFiled.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
//    _enterTextFiled.layer.borderWidth = 0f;
    _enterTextFiled.layer.cornerRadius = 25.0f;
    [self.view addSubview:_enterTextFiled];
    [_enterTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(50);
            make.bottom.equalTo(self.view.mas_top).offset(295);
            make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _enterTextFiled.textAlignment = NSTextAlignmentCenter;
    _enterTextFiled.placeholder = @"请输入账号";
    
    _registerTextFiled = [[UITextField alloc]init];
    _registerTextFiled.backgroundColor = [UIColor colorWithRed:242/255 green:243/255 blue:246/255 alpha:0.1];
    _registerTextFiled.layer.borderColor = [[UIColor blackColor] CGColor];
//    _registerTextFiled.layer.borderWidth = 0.8f;
    _registerTextFiled.layer.cornerRadius = 25.0f;
    [self.view addSubview:_registerTextFiled];
    [_registerTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(50);
            make.bottom.equalTo(self.view.mas_top).offset(365);
            make.size.mas_equalTo(CGSizeMake(340,50));
    }];
    _registerTextFiled.textAlignment = NSTextAlignmentCenter;
    _registerTextFiled.placeholder = @"请输入密码";
    _registerTextFiled.secureTextEntry = YES;
    
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_enterButton];
    [_enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(150);
            make.bottom.equalTo(self.view.mas_top).offset(520);
            make.size.mas_equalTo(CGSizeMake(128,128));
    }];
//    _enterButton.frame = CGRectMake(120, 400, 128, 128);
    [_enterButton setImage:[UIImage imageNamed:@"denglu-3.png"] forState:UIControlStateNormal];
//    [_enterButton setTitle:@"登录" forState:UIControlStateNormal];
    _enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_enterButton addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_right).offset(-150);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
            make.size.mas_equalTo(CGSizeMake(100,100));
    }];
//    _registerButton.frame = CGRectMake(260, 400, 50, 50);
    [_registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_registerButton addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];


    
    _messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_messageButton];
    [_messageButton setTitle:@"手机号登录" forState:UIControlStateNormal];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(50);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
            make.size.mas_equalTo(CGSizeMake(100,100));
    }];
//    _messageButton.frame = CGRectMake(25, 800, 380, 50);
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_messageButton addTarget:self action:@selector(pressMessageButton) forControlEvents:UIControlEventTouchUpInside];

    
//qq、微信登录    
//如果是这两个登录的话，客户端需要将qqId发给后台，后台返回是否需要绑定手机号（不需要就返回个人信息，需要就跳转到绑定手机号页面
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self queryData];
}

- (void)pressLogin {
    int i = 0;
    int flag = 0;
    while (_testName.count != i ) {
        if ([_testName[i] isEqual:_enterTextFiled.text] && [_passName[i] isEqual:_registerTextFiled.text]) {
            flag = 1;
            break;
        } 
        i++;
    }
    if (flag == 1 ) {
        RecognitionViewController *recognitionViewController = [[RecognitionViewController alloc]init];
        MapViewController *mapViewController = [[MapViewController alloc]init];
        GuideViewController *guideViewController = [[GuideViewController alloc]init];
        MyViewController *myViewController = [[MyViewController alloc]init];
        
        myViewController.numberTestString = _enterTextFiled.text;
        
        recognitionViewController.title = @"识别";
        mapViewController.title = @"回收";
        guideViewController.title = @"指南";
        myViewController.title = @"我的";
        
        UINavigationController *a1 = [[UINavigationController alloc]initWithRootViewController:recognitionViewController];
        UINavigationController *a2 = [[UINavigationController alloc]initWithRootViewController:mapViewController];
        UINavigationController *a3 = [[UINavigationController alloc]initWithRootViewController:guideViewController];
        UINavigationController *a4 = [[UINavigationController alloc]initWithRootViewController:myViewController];

        recognitionViewController.view.backgroundColor = [UIColor whiteColor];
        mapViewController.view.backgroundColor = [UIColor whiteColor];
        guideViewController.view.backgroundColor = [UIColor whiteColor];
        myViewController.view.backgroundColor = [UIColor whiteColor];

        NSArray *array = [[NSArray alloc]initWithObjects:a1,a2,a3,a4,nil];
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 10)];
        tabBarController.viewControllers = array;
        self.view.window.rootViewController = tabBarController;
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"输入有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

- (void)pressRegister {
    //客户端将手机号、密码以及短信验证码发给后台，后台进行检验再返回数据给客户端（是否注册成功）
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    registerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:registerViewController animated:YES completion:nil];
}

- (void)pressMessageButton {
    //客户端将手机号发给后台，后台返回是否发送成功
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) queryData{
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
    NSLog(@"%@",self.path);
    if ([dataBase open]) {
    // 1.执行查询语句
    FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM t_agreeOrder"];
    // 2.遍历结果
        self.testName = [[NSMutableArray alloc]init];
        self.passName = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        NSString *bankStr = [resultSet stringForColumn:@"name"];
        [self.testName addObject:bankStr];
        NSString *passStr = [resultSet stringForColumn:@"pass"];
        [self.passName addObject:passStr];
    }
        [dataBase close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

@end
