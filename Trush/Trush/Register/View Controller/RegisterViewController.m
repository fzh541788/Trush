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

@interface RegisterViewController ()
@property (nonatomic, strong) RegisterView *registerView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _registerView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_registerView];
    _registerView.backgroundColor = [UIColor whiteColor];
    [_registerView.returnButton addTarget:self action:@selector(pressReturnButton) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.backButton addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
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
    if (_registerView.enterTextFiled.text == NULL && _registerView.registerTextFiled.text == NULL) {
        NSLog(@"弹窗 失败");
    } else {
        FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
        if ([dataBase open]) {
        BOOL res = [self.dataBase executeUpdate:@"INSERT INTO t_agreeOrder (name, pass) VALUES (?,?);",_registerView.enterTextFiled.text,_registerView.registerTextFiled.text];
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
