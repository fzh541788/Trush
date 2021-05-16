//
//  RegisterViewController.m
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import "RegisterViewController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "RegisterView.h"
#import "RegisterModel.h"
#import "AFNetworking.h"
#import "Manage.h"
#import "MyActivityIndicatorView.h"

@interface RegisterViewController ()
@property (nonatomic, strong) RegisterView *registerView;
@property (nonatomic, strong) MyActivityIndicatorView *myActivityIndicatorView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _registerView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_registerView];
    _registerView.backgroundColor = [UIColor whiteColor];
    [_registerView.sureButton addTarget:self action:@selector(pressReturnButton) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)pressReturnButton {
    self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_myActivityIndicatorView];
    [_myActivityIndicatorView startAnimating];
    [[Manage sharedManager]registerNetWork:_phone andPassword:_registerView.enterTextField.text andMsgCode:_registerView.registerTextField.text and:^(RegisterModel * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"%d",mainViewNowModel.status);
            if (mainViewNowModel.status == 0 ) {
                [self->_myActivityIndicatorView stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
//                [self->_myActivityIndicatorView stopAnimating];
            } else {
                [self->_myActivityIndicatorView stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
            }
        });
    } error:^(NSError * _Nonnull error) {
        [self->_myActivityIndicatorView stopAnimating];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    }];
}

- (void)pressBackButton {
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
