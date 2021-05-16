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
#import "ChangePassWordModel.h"
#import "Manage.h"
#import "MyActivityIndicatorView.h"
#import "AFNetworking.h"
#import "ChangeInformationViewController.h"

@interface MyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) FourthView *fourthView;
@property (nonatomic, strong) MyActivityIndicatorView *myActivityIndicatorView;
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
    _fourthView.phone = _numberTestString;
    _fourthView.msg = _msg;
    _fourthView.name = _name;
    _fourthView.sex = _sex;
    _fourthView.stage = _stage;
    _fourthView.img = _img;
    [self.view addSubview:_fourthView];
    
    self.navigationItem.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickAnalyse) name:@"clickAnalyse" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickChangeInformation) name:@"clickChangeInformation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickLookInformation) name:@"clickLookInformation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickChange) name:@"clickChange" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickForget) name:@"clickForget" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickHelp) name:@"clickHelp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickQuit) name:@"clickQuit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressPhone) name:@"headImageView" object:nil];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needReload:) name:@"NeedReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needSecondReload:) name:@"NeedReloadSecond" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexNeedReload:) name:@"SexNeedReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stageNeedReload:) name:@"StageNeedReload" object:nil];
}

- (void)clickAnalyse {
    //    点击“我的”tab，客户端就去请求后台接口，上传用户id，后台计算出当前用户搜索物品的各个垃圾分类所占的百分比，客户端展现出来。
    AnalyseViewController *analyseViewController = [[AnalyseViewController alloc]init];
   
    [[Manage sharedManager]networkofAnalyse:_numberTestString and:^(AnalyseModel * _Nonnull mainViewNowModel) {
        if (mainViewNowModel.status == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                analyseViewController.pieDataArray = [[NSMutableArray alloc]init];
                [analyseViewController.pieDataArray addObject:[NSString stringWithFormat:@"%d",mainViewNowModel.data.gcountl.dry]];
                [analyseViewController.pieDataArray addObject:[NSString stringWithFormat:@"%d",mainViewNowModel.data.gcountl.wet]];
                [analyseViewController.pieDataArray addObject:[NSString stringWithFormat:@"%d",mainViewNowModel.data.gcountl.recyclable]];
                [analyseViewController.pieDataArray addObject:[NSString stringWithFormat:@"%d",mainViewNowModel.data.gcountl.harm]];
                [self.navigationController pushViewController:analyseViewController animated:NO];
            });
        }
    } error:^(NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
}

- (void)clickChangeInformation {
    //    ManageViewController *manageViewController = [[ManageViewController alloc]init];
    //    [self.navigationController pushViewController:manageViewController animated:YES];
    ChangeInformationViewController *changeInformationViewController = [[ChangeInformationViewController alloc]init];
    changeInformationViewController.msg = _msg;
    changeInformationViewController.name = _name;
    changeInformationViewController.phone = _numberTestString;
    changeInformationViewController.sex = _sex;
    changeInformationViewController.stage = _stage;
    [self.navigationController pushViewController:changeInformationViewController animated:YES];
}

- (void)clickLookInformation {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您目前没有通知！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)clickChange {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新密码" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入修改后的密码";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self->_myActivityIndicatorView];
        [self->_myActivityIndicatorView startAnimating];
        [[Manage sharedManager]netWorkOfChangePassword:alert.textFields.firstObject.text and:self->_numberTestString and:^(ChangePassWordModel * _Nonnull mainViewNowModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mainViewNowModel.status == 0) {
                    [self->_myActivityIndicatorView stopAnimating];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:mainViewNowModel.msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //                        [self dismissViewControllerAnimated:NO completion:nil];
                        [self clickQuit];
                    }];
                    [alert addAction:sureAction];
                    [self presentViewController:alert animated:NO completion:nil];
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


- (void)clickHelp {
    
}

- (void)clickQuit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)needReload:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    self.fourthView.name = dic[@"name"];
    _name = dic[@"name"];
    [self.fourthView.tableView reloadData];
}

- (void)needSecondReload:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    self.fourthView.msg = dic[@"msg"];
    _msg = dic[@"msg"];
    [self.fourthView.tableView reloadData];
}

- (void)sexNeedReload:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    self.fourthView.sex = dic[@"sex"];
    _sex = dic[@"sex"];
    [self.fourthView.tableView reloadData];
}

- (void)stageNeedReload:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    self.fourthView.stage = dic[@"stage"];
    _stage = dic[@"stage"];
    [self.fourthView.tableView reloadData];
}

- (void)pressPhone {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    
    /*关于UIAlertActionStyle有三种样式
     UIAlertActionStyleDefault  , 默认样式
     UIAlertActionStyleCancel,      取消
     UIAlertActionStyleDestructive, 有毁灭性的操作是使用, 呈现红色
     */
    [alertViewController addAction:cancle];
    [alertViewController addAction:photo];
    [alertViewController addAction:picture];
    // support iPad
    alertViewController.popoverPresentationController.sourceView = self.view;
    alertViewController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height, 1.0, 1.0);
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //设置UIImagePickerController的代理，同时要遵循
        //UIImagePickerControllerDelegate，
        //UINavigationControllerDelegate协议
        picker.delegate = self;
        
        //设置拍照之后图片是否可编辑，如果设置成可编辑的话会
        //在代理方法返回的字典里面多一些键值。PS：
        //如果在调用相机的时候允许照片可编辑，
        //那么用户能编辑的照片的位置并不包括边角。
        picker.allowsEditing = YES;
        
        //UIImagePicker选择器的类型，UIImagePickerControllerSourceTypeCamera调用系统相机
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        NSLog(@"拍照中");
    }
    else{
        //如果当前设备没有摄像头
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    }
    
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum {
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image,1.0f);
    self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self->_myActivityIndicatorView];
    [self->_myActivityIndicatorView startAnimating];
    [[Manage sharedManager]networkofChangeHeadImage:_numberTestString and:imageData and:^(ChangeHeadImage * _Nonnull mainViewNowModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(mainViewNowModel.status == 0) {
                [self->_myActivityIndicatorView stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更改成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    self->_img = mainViewNowModel.data.img;
                    self->_fourthView.img = mainViewNowModel.data.img;
                    [self->_fourthView.tableView reloadData];
                }];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
            } else {
                [self->_myActivityIndicatorView stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更新失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
            }
        });
        } error:^(NSError * _Nonnull error) {
            NSLog(@"网络请求失败");
        }];
}


@end
