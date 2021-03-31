//
//  GuideViewController.m
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *tabBarImage = [UIImage imageNamed:@"kehutousu.png"];
    UITabBarItem *thirdTabBarItem = [[UITabBarItem alloc]initWithTitle:@"指南" image:tabBarImage tag:4];
    thirdTabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    self.tabBarItem = thirdTabBarItem;
    self.view.backgroundColor = [UIColor colorWithRed:0.6784 green:0.91 blue:0.4627 alpha:1];
    // Do any additional setup after loading the view.
    
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollerView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2 + 30);
    [self.view addSubview:_scrollerView];
    _scrollerView.pagingEnabled = NO;
    _scrollerView.delegate = self;

    _firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Guide1.png"]];
    _firstImageView.frame = CGRectMake(5, 5, self.view.frame.size.width - 10, self.view.frame.size.height);
    [_scrollerView addSubview:_firstImageView];
    
    _secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Guide2.png"]];
    _secondImageView.frame = CGRectMake(5, self.view.frame.size.height + 10, self.view.frame.size.width - 10, self.view.frame.size.height);
    [_scrollerView addSubview:_secondImageView];
    
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
