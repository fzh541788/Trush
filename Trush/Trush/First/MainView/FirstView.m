//
//  FirstView.m
//  Trush
//
//  Created by young_jerry on 2020/11/30.
//

#import "FirstView.h"
//#import "Masonry.h"

@implementation FirstView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, 340, 60)];
    _searchTextField.layer.borderWidth = 1;
    _searchTextField.placeholder = @"请输入垃圾名称";
    
    UIImageView *searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"上传.png"]];
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = searchImage;
    
    [self addSubview:_searchTextField];

    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:@"搜索   " forState:UIControlStateNormal];
    [_searchButton setTintColor:[UIColor grayColor]];
    _searchTextField.rightViewMode = UITextFieldViewModeAlways;
    _searchTextField.rightView = _searchButton;

    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(50, 500, 128, 128)];
    containView.backgroundColor = [UIColor grayColor];
    containView.layer.cornerRadius = 64;
    containView.clipsToBounds = YES;
    _pictureButton = [[UIButton alloc]init];
    [_pictureButton setFrame:CGRectMake(0, 0, 128, 128)];
    [containView addSubview:_pictureButton];
    [_pictureButton setImage:[UIImage imageNamed:@"shumajiadian.png"] forState:UIControlStateNormal];
    [self addSubview:containView];

    UIView *containRightView = [[UIView alloc] initWithFrame:CGRectMake(250, 500, 128, 128)];
    containRightView.backgroundColor = [UIColor grayColor];
    containRightView.layer.cornerRadius = 64;
    containRightView.clipsToBounds = YES;
    _voiceButton = [[UIButton alloc]init];
    [_voiceButton setFrame:CGRectMake(0, 0, 128, 128)];
    [containRightView addSubview:_voiceButton];
    [_voiceButton setImage:[UIImage imageNamed:@"yuyin-2.png"] forState:UIControlStateNormal];
    [self addSubview:containRightView];
    
    UIView *hotSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 4 + 20  , self.bounds.size.width, 200)];
    hotSearchView.backgroundColor = [UIColor grayColor];
    [self addSubview:hotSearchView];
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
