//
//  DryViewController.m
//  Trush
//
//  Created by young_jerry on 2021/4/11.
//

#import "DryViewController.h"

@interface DryViewController ()

@end

@implementation DryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:view];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dry.jpeg"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    [view addSubview:imageView];
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
