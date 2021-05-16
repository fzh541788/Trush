//
//  PhoneNumberViewController.m
//  Trush
//
//  Created by young_jerry on 2021/4/18.
//

#import "PhoneNumberViewController.h"
#import "PhoneNumberView.h"
#import "PhoneNumberModel.h"
#import "Manage.h"
#import "RegisterViewController.h"

@interface PhoneNumberViewController ()

@property (nonatomic, strong) PhoneNumberView *phoneNumberView;
@property (nonatomic, strong) PhoneNumberModel *phoneNumberModel;

@end

@implementation PhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _phoneNumberView = [[PhoneNumberView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _phoneNumberView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_phoneNumberView];
    
    [_phoneNumberView.sureButton addTarget:self action:@selector(pressSureButton) forControlEvents:UIControlEventTouchUpInside];
    [_phoneNumberView.backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)pressSureButton {
    if (_phoneNumberView.phoneNumberTextField.text.length != 11 ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    } else {
        [[Manage sharedManager]netWorkPhoneNumber:_phoneNumberView.phoneNumberTextField.text and:^(PhoneNumberModel * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //            NSLog(@"%d",mainViewNowModel.status);
                if (mainViewNowModel.status == 0 ) {
                    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
                    registerViewController.phone = self->_phoneNumberView.phoneNumberTextField.text;
                    registerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:registerViewController animated:YES completion:nil];
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:sureAction];
                    [self presentViewController:alert animated:NO completion:nil];
                }
            });
        } error:^(NSError * _Nonnull error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:NO completion:nil];
        }];
        
    }
}

- (void)pressBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
