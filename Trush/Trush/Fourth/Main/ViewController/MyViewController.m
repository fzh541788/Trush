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
#import "AnalyseViewController.h"
#import "FMDB.h"

@interface MyViewController ()
@property (nonatomic, strong) FourthView *fourthView;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImage *tabBarImage = [UIImage imageNamed:@"kehuxiangqing-2.png"];
    UITabBarItem *fourthTabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:tabBarImage tag:1];
//    [fourthTabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 10)];
    fourthTabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    self.tabBarItem = fourthTabBarItem;
    _fourthView = [[FourthView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_fourthView];
    self.navigationItem.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickAnalyse) name:@"clickAnalyse" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickChangeInformation) name:@"clickChangeInformation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickManage) name:@"clickManage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickChange) name:@"clickChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickForget) name:@"clickForget" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickHelp) name:@"clickHelp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickQuit) name:@"clickQuit" object:nil];
}

- (void)clickAnalyse {
//    点击“我的”tab，客户端就去请求后台接口，上传用户id，后台计算出当前用户搜索物品的各个垃圾分类所占的百分比，客户端展现出来。
    AnalyseViewController *analyseViewController = [[AnalyseViewController alloc]init];
    [self.navigationController pushViewController:analyseViewController animated:NO];
    analyseViewController.pieDataArray = [[NSArray alloc]initWithObjects:@"100",@"200",@"300",nil];
    
}

- (void)clickChangeInformation {
    //客户端将修改后的个人信息发给后台（昵称、性别、头像），后台返回是否更新成功
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

- (void)clickForget {
//    客户端将手机号、验证码以及新的密码发给后台，后台返回是否修改成功
}

- (void)clickHelp {
    
}

- (void)clickQuit {
    ViewController *viewController = [[ViewController alloc]init];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:viewController animated:YES completion:nil];
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
