//
//  RegisterViewController.m
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import "RegisterViewController.h"
#import "ViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    _returnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _returnButton.frame = CGRectMake(180, 500, 50, 50);
    [_returnButton setTitle:@"登录" forState:UIControlStateNormal];
    _returnButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_returnButton addTarget:self action:@selector(pressReturnButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_returnButton];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backButton setTitle:@"<" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:50];
    _backButton.frame = CGRectMake(20, 80, 50, 50);
    [self.view addSubview:_backButton];
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"NameAndPass.sqlite"];
    self.path = fileName;
//    NSLog(@"%@",fileName);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
    //3.打开数据库
    if ([dataBase open]) {
           //4.创表
           BOOL result=[dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_agreeOrder ('name' TEXT, 'pass' TEXT);"];
           if (result) {
                        NSLog(@"创表成功");
                    } else {
                        NSLog(@"创表失败");
                    }
     }
    self.dataBase = dataBase;
}

- (void)pressReturnButton {
    if (_enterTextFiled.text == NULL && _registerTextFiled.text == NULL) {
        NSLog(@"弹窗 失败");
    } else {
        FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
        if ([dataBase open]) {
        BOOL res = [self.dataBase executeUpdate:@"INSERT INTO t_agreeOrder (name, pass) VALUES (?,?);",_enterTextFiled.text,_registerTextFiled.text];
        if (!res) {
            NSLog(@"增加数据失败!");
        } else {
            NSLog(@"添加数据成功!");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
          [dataBase close];
        }
}
}

- (void)pressBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
