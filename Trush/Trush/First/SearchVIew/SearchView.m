//
//  SearchView.m
//  Trush
//
//  Created by young_jerry on 2020/12/2.
//

#import "SearchView.h"

@implementation SearchView
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
