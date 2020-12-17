//
//  AnalyseViewController.m
//  Trush
//
//  Created by young_jerry on 2020/12/16.
//

#import "AnalyseViewController.h"
#import "AnalyseView.h"

@interface AnalyseViewController ()

@property (nonatomic, strong) AnalyseView *analyseView;

@end

@implementation AnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _analyseView = [[AnalyseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andDataArray:self.pieDataArray];
    [self.view addSubview:_analyseView];
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
