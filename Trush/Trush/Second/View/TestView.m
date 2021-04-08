//
//  TestView.m
//  Trush
//
//  Created by young_jerry on 2021/3/31.
//

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //    NSLog(@"button has been press123");
    self.backgroundColor = [UIColor whiteColor];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setFrame:CGRectMake(self.bounds.size.width * 0.0701, 25, 65, 65)];
    [_upButton setImage:[UIImage imageNamed:@"zengjia-3.png"] forState:UIControlStateNormal];
    [self addSubview:_upButton];
    UILabel *upLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 80, 30)];
    upLabel.text = @"增加回收点";
    upLabel.textColor = [UIColor blackColor];
    upLabel.font = [UIFont systemFontOfSize:13];
    [_upButton addSubview:upLabel];
    
    _nearlyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nearlyButton setFrame:CGRectMake(self.bounds.size.width * 0.56075, 30, 55, 55)];
    [_nearlyButton setImage:[UIImage imageNamed:@"08.png"] forState:UIControlStateNormal];
    [self addSubview:_nearlyButton];
    UILabel *nearlyLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, 55, 80, 30)];
    nearlyLabel.text = @"附近回收点";
    nearlyLabel.textColor = [UIColor blackColor];
    nearlyLabel.font = [UIFont systemFontOfSize:13];
    [_nearlyButton addSubview:nearlyLabel];
    
    _delegtWayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delegtWayButton setFrame:CGRectMake(self.bounds.size.width * 0.327, 20, 64, 64)];
    [_delegtWayButton setImage:[UIImage imageNamed:@"luxian.png"] forState:UIControlStateNormal];
    [self addSubview:_delegtWayButton];
    UILabel *delegtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 80, 30)];
    delegtLabel.text = @"取消规划";
    delegtLabel.textColor = [UIColor blackColor];
    delegtLabel.font = [UIFont systemFontOfSize:13];
    [_delegtWayButton addSubview:delegtLabel];
    
    
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refreshButton setFrame:CGRectMake(self.bounds.size.width * 0.7944, 30, 55, 55)];
    [_refreshButton setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateNormal];
    [self addSubview:_refreshButton];
    UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 80, 30)];
    refreshLabel.text = @"刷新规划";
    refreshLabel.textColor = [UIColor blackColor];
    refreshLabel.font = [UIFont systemFontOfSize:13];
    [_refreshButton addSubview:refreshLabel];
    
    _pictureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_pictureButton setTitle:@"图片" forState:UIControlStateNormal];
    _pictureButton.frame = CGRectMake(170, 140, 80, 20);
    [self addSubview:_pictureButton];
    _pictureButton.hidden = YES;
    
    return self;
}

@end
