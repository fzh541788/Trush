//
//  MyViewController.m
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import "MyViewController.h"
#import "FourthView.h"
#import "ViewController.h"
#import "ManageViewController.h"
#import "FMDB.h"

@interface MyViewController ()
@property (nonatomic, strong) FourthView *fourthView;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _fourthView = [[FourthView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_fourthView];
    self.navigationItem.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickQuit) name:@"clickQuit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickManage) name:@"clickManage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickChange) name:@"clickChange" object:nil];
}

- (void)clickQuit {
    ViewController *viewController = [[ViewController alloc]init];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)clickManage {
    ManageViewController *manageViewController = [[ManageViewController alloc]init];
    [self.navigationController pushViewController:manageViewController animated:YES];
}

- (void)clickChange {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新密码" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入修改后的密码";
    }];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *passField = alert.textFields.firstObject;
        self->_passTestString = passField.text;
        FMDatabase *dataBase = [FMDatabase databaseWithPath:self.fourthView.path];
        if ([dataBase open]) {
            BOOL result = [dataBase executeUpdate:@"update t_agreeOrder set pass = ? where name = ?",self.passTestString,self.numberTestString];
            if (result) {
                NSLog(@"修改成功");
            } else {
                NSLog(@"修改失败");
            }
                [dataBase close];
            }
    }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:NO completion:nil];
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
