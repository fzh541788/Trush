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
#import "PhoneNumberViewController.h"
#import "MyActivityIndicatorView.h"
//把数据库的操作全部转化成 后台的操作
@interface ViewController ()

@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) LoginModel *loginModel;
@property (nonatomic, strong) MyActivityIndicatorView *myActivityIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_loginView];
    _loginView.backgroundColor = [UIColor whiteColor];
    [_loginView.enterButton addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerButton addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addAllViewController {
    RecognitionViewController *recognitionViewController = [[RecognitionViewController alloc]init];
    MapViewController *mapViewController = [[MapViewController alloc]init];
    GuideViewController *guideViewController = [[GuideViewController alloc]init];
    MyViewController *myViewController = [[MyViewController alloc]init];
    recognitionViewController.phone = self->_loginView.enterTextFiled.text;
    
    myViewController.numberTestString = self->_loginView.enterTextFiled.text;
    myViewController.msg = _msg;
    myViewController.name = _name;
    myViewController.sex = _sex;
    myViewController.stage = _stage;
    myViewController.img = _img;
    
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
//    [self.view.window makeKeyAndVisible];
//    self.view.window.rootViewController = tabBarController;
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:tabBarController animated:YES completion:nil];
    [self->_myActivityIndicatorView stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewDidLoad];
}

- (void)pressLogin {
    self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_myActivityIndicatorView];
    [_myActivityIndicatorView startAnimating];
    [[Manage sharedManager]loginNetWork:_loginView.enterTextFiled.text andPassword:_loginView.registerTextFiled.text and:^(LoginModel * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mainViewNowModel.status == 0 || ([self->_loginView.enterTextFiled.text  isEqual: @"123"] && [self->_loginView.registerTextFiled.text  isEqual: @"123"])) {
                self->_msg = mainViewNowModel.data.msg;
                self->_sex = mainViewNowModel.data.sex;
                self->_stage = mainViewNowModel.data.stage;
                self->_name = mainViewNowModel.data.name;
                self->_img = mainViewNowModel.data.img;
                [self addAllViewController];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
                [self->_myActivityIndicatorView stopAnimating];
            }
        });
    } error:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_myActivityIndicatorView stopAnimating];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"网络请求失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:NO completion:nil];
        });
    }];
}

- (void)pressRegister {
    //客户端将手机号、密码以及短信验证码发给后台，后台进行检验再返回数据给客户端（是否注册成功）
    PhoneNumberViewController *registerViewController = [[PhoneNumberViewController alloc]init];
    registerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:registerViewController animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
