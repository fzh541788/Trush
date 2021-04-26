//
//  SearchViewController.m
//  Trush
//
//  Created by young_jerry on 2020/12/2.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "Manage.h"
#import "ResultViewController.h"
#import "MyActivityIndicatorView.h"
//#import "PictureModel.h"
@interface SearchViewController ()

@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) ResultViewController *secondView;
@property (nonatomic, strong) MyActivityIndicatorView *myActivityIndicatorView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _secondView = [[ResultViewController alloc]init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_searchView];
    [_searchView.searchButton addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
}
- (void)pressSearch {
    self.myActivityIndicatorView = [[MyActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_myActivityIndicatorView];
    [_myActivityIndicatorView startAnimating];
    [[Manage sharedManager]netWorkText:[_searchView.searchTextField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] and:^(TextModel * _Nonnull mainViewNowModel) {
        if (!mainViewNowModel.data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_myActivityIndicatorView stopAnimating];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"未找到" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [self presentViewController:alert animated:NO completion:nil];
            });
        } else {
            self->_secondView.maybe = [[NSMutableArray alloc]init];
            self->_secondView.name = [[NSMutableArray alloc]init];
            for (int i = 0; i < mainViewNowModel.data.list.count; i++) {
                [self->_secondView.maybe addObject:[mainViewNowModel.data.list[i]category]];
                [self->_secondView.name addObject:[mainViewNowModel.data.list[i]name]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.secondView.tableView reloadData];
                [self presentViewController:self->_secondView animated:YES completion:nil];
                [self->_myActivityIndicatorView stopAnimating];
            });
        }
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
