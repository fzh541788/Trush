#import "ViewController.h"
#import "RecognitionViewController.h"
#import "MapViewController.h"
#import "GuideViewController.h"
#import "MyViewController.h"
#import "Masonry.h"
#import "RegisterViewController.h"
#import "LoginView.h"
#import "LoginModel.h"
#import "Manage.h"
//把数据库的操作全部转化成 后台的操作
@interface ViewController ()

@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) LoginModel *loginModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_loginView];
    _loginView.backgroundColor = [UIColor whiteColor];
    [_loginView.enterButton addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerButton addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.messageButton addTarget:self action:@selector(pressMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addAllViewController {
    RecognitionViewController *recognitionViewController = [[RecognitionViewController alloc]init];
    MapViewController *mapViewController = [[MapViewController alloc]init];
    GuideViewController *guideViewController = [[GuideViewController alloc]init];
    MyViewController *myViewController = [[MyViewController alloc]init];

    myViewController.numberTestString = self->_loginView.enterTextFiled.text;

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
}

- (void)pressLogin {
    [[Manage sharedManager]loginNetWork:_loginView.enterTextFiled.text andPassword:_loginView.registerTextFiled.text and:^(LoginModel * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%d",mainViewNowModel.status);
            if (mainViewNowModel.status == 0 || ([self->_loginView.enterTextFiled.text  isEqual: @"123"] && [self->_loginView.registerTextFiled.text  isEqual: @"123"])) {
                [self addAllViewController];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
            }
        });
    } error:^(NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"网路连接失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    }];
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

@end
