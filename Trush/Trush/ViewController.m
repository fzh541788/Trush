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
    _enterTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 80)];
    _enterTextFiled.placeholder = @"   请输入账号";
    _enterTextFiled.font = [UIFont systemFontOfSize:20];
    _enterTextFiled.layer.borderWidth = 1;
    
    _registerTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 300, self.view.frame.size.width - 20, 80)];
    _registerTextFiled.placeholder = @"   请输入密码";
    _registerTextFiled.font = [UIFont systemFontOfSize:20];
    _registerTextFiled.layer.borderWidth = 1;
    [self.view addSubview:_enterTextFiled];
    [self.view addSubview:_registerTextFiled];
    
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _enterButton.frame = CGRectMake(120, 400, 50, 50);
    [_enterButton setTitle:@"登录" forState:UIControlStateNormal];
    _enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_enterButton addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _registerButton.frame = CGRectMake(260, 400, 50, 50);
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_registerButton addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterButton];
    [self.view addSubview:_registerButton];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageButton setTitle:@"用短信验证码登录" forState:UIControlStateNormal];
    _messageButton.frame = CGRectMake(25, 800, 380, 50);
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_messageButton addTarget:self action:@selector(pressMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_messageButton];
    
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
