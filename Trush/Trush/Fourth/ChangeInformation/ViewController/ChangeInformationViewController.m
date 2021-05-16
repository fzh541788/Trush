//
//  ChangeInformationViewController.m
//  Trush
//
//  Created by young_jerry on 2021/5/8.
//

#import "ChangeInformationViewController.h"
#import "ChangeInformation.h"
#import "ChangeInformationView.h"
#import "MyActivityIndicatorView.h"
#import "MyViewController.h"
#import "Manage.h"

@interface ChangeInformationViewController ()

@property (nonatomic, strong) ChangeInformation *model;
@property (nonatomic, strong) ChangeInformationView *informationView;
@property (nonatomic, strong) MyActivityIndicatorView *myActivityIndicatorView;

@end

@implementation ChangeInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _informationView = [[ChangeInformationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _informationView.msg = _msg;
    _informationView.name = _name;
    _informationView.phone = _phone;
    _informationView.sex = _sex;
    _informationView.stage = _stage;
    [self.view addSubview:_informationView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickName) name:@"clickName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickMsg) name:@"clickMsg" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickSex) name:@"clickSex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickStage) name:@"clickStage" object:nil];
}

- (void)clickName {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新昵称" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新昵称";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self->_myActivityIndicatorView];
        [self->_myActivityIndicatorView startAnimating];
        [[Manage sharedManager]netWorkOfChangeInformation:self->_phone and:alert.textFields.firstObject.text and:self->_msg and:self->_sex and:self->_stage and:^(ChangeInformation * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mainViewNowModel.status == 0) {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alertSecond = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        self.informationView.name = alert.textFields.firstObject.text;
                        self.name = alert.textFields.firstObject.text;
                        NSNotification *noti = [NSNotification notificationWithName:@"NeedReload" object:self userInfo:@{@"name":alert.textFields.firstObject.text}];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        [self.informationView.tableView reloadData];
                        
                    }];
                    [alertSecond addAction:sureAction];
                    [self presentViewController:alertSecond animated:NO completion:nil];
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
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)clickMsg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新个性签名" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新个性签名";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self->_myActivityIndicatorView];
        [self->_myActivityIndicatorView startAnimating];
        [[Manage sharedManager]netWorkOfChangeInformation:self->_phone and:self->_name and:alert.textFields.firstObject.text and:self->_sex and:self->_stage and:^(ChangeInformation * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mainViewNowModel.status == 0) {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alertSecond = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        self.msg = alert.textFields.firstObject.text;
                        self.informationView.msg = alert.textFields.firstObject.text;
                        NSNotification *noti = [NSNotification notificationWithName:@"NeedReloadSecond" object:self userInfo:@{@"msg":alert.textFields.firstObject.text}];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        [self.informationView.tableView reloadData];
                        
                    }];
                    [alertSecond addAction:sureAction];
                    [self presentViewController:alertSecond animated:NO completion:nil];
                } else {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:sureAction];
                    [self presentViewController:alert animated:NO completion:nil];
                }
            });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [self->_myActivityIndicatorView stopAnimating];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:NO completion:nil];
        }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)clickSex {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入性别" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入性别";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self->_myActivityIndicatorView];
        [self->_myActivityIndicatorView startAnimating];
        [[Manage sharedManager]netWorkOfChangeInformation:self->_phone and:self->_name and:self->_msg and:alert.textFields.firstObject.text and:self->_stage and:^(ChangeInformation * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mainViewNowModel.status == 0) {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alertSecond = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        self.informationView.sex = alert.textFields.firstObject.text;
                        self.sex = alert.textFields.firstObject.text;
                        NSNotification *noti = [NSNotification notificationWithName:@"SexNeedReload" object:self userInfo:@{@"sex":alert.textFields.firstObject.text}];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        [self.informationView.tableView reloadData];
                        
                    }];
                    [alertSecond addAction:sureAction];
                    [self presentViewController:alertSecond animated:NO completion:nil];
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
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)clickStage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入当前学习阶段" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入当前学习阶段";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self->_myActivityIndicatorView];
        [self->_myActivityIndicatorView startAnimating];
        [[Manage sharedManager]netWorkOfChangeInformation:self->_phone and:self->_name and:self->_msg and:self->_sex and:alert.textFields.firstObject.text and:^(ChangeInformation * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mainViewNowModel.status == 0) {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alertSecond = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        self.informationView.stage = alert.textFields.firstObject.text;
                        self.stage = alert.textFields.firstObject.text;
                        NSNotification *noti = [NSNotification notificationWithName:@"StageNeedReload" object:self userInfo:@{@"stage":alert.textFields.firstObject.text}];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        [self.informationView.tableView reloadData];
                        
                    }];
                    [alertSecond addAction:sureAction];
                    [self presentViewController:alertSecond animated:NO completion:nil];
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
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:NO completion:nil];
}

@end
