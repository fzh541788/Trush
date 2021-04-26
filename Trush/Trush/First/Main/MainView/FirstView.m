//
//  FirstView.m
//  Trush
//
//  Created by young_jerry on 2020/11/30.
//

#import "FirstView.h"
#import "Masonry.h"
#import "FirstTableViewCell.h"

@implementation FirstView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //加圆角view
    //下面改两个正方形+4组的cell + cell点击事件
    UIView *backgrandView = [[UIView alloc]init];
    [self addSubview:backgrandView];
    [backgrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top).offset(82);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width,self.bounds.size.height / 6));
    }];
    backgrandView.clipsToBounds = YES;
    backgrandView.layer.cornerRadius = 16;
    backgrandView.backgroundColor = [UIColor colorWithRed:0.6745 green:0.7647 blue:0.2863 alpha:1];
    
    
    
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _searchTextField.layer.cornerRadius = 25.0f;
    [self addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_top).offset(160);
        make.size.mas_equalTo(CGSizeMake(400,50));
    }];
    [_searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIColor *color = [UIColor colorWithRed:0.6745 green:0.7647 blue:0.2863 alpha:1];
    _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入垃圾名称" attributes:@{NSForegroundColorAttributeName: color}];
    _searchTextField.textAlignment = NSTextAlignmentCenter;
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:@"搜索   " forState:UIControlStateNormal];
    [_searchButton setTintColor:[UIColor grayColor]];
    _searchTextField.rightViewMode = UITextFieldViewModeAlways;
    _searchTextField.rightView = _searchButton;
    
    UIView *topBackgrandView = [[UIView alloc]init];
    [self addSubview:topBackgrandView];
    [topBackgrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(_searchTextField.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(400, 190));
    }];
    topBackgrandView.clipsToBounds = YES;
    
    topBackgrandView.layer.cornerRadius = 16;
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"16148.jpg"]];
    topImageView.frame = CGRectMake(0, 0, 400, 190);
    [topBackgrandView addSubview:topImageView];
    
    _tableView = [[UITableView alloc]init];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(topBackgrandView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"firstSonIdentifier"];
    
    UIView *containView = [[UIView alloc] init];
    [self addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(topBackgrandView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width / 2 , 120));
    }];
    containView.backgroundColor = [UIColor whiteColor];
    //    containView.layer.borderWidth = 0.2;
    //    containView.layer.cornerRadius = 64;
    //    containView.clipsToBounds = YES;
    _pictureButton = [[UIButton alloc]init];
    [_pictureButton setFrame:CGRectMake(0, 0,self.bounds.size.width / 2 , 120)];
    [containView addSubview:_pictureButton];
    [_pictureButton setImage:[UIImage imageNamed:@"xianxingxiangji.png"] forState:UIControlStateNormal];
    
    
    UIView *containRightView = [[UIView alloc] init];
    [self addSubview:containRightView];
    [containRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containView.mas_right);
        make.top.equalTo(topBackgrandView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width / 2 , 120));
    }];
    containRightView.backgroundColor = [UIColor whiteColor];
    //    containRightView.layer.borderWidth = 0.2;
    //    containRightView.layer.cornerRadius = 64;
    //    containRightView.clipsToBounds = YES;
    _voiceButton = [[UIButton alloc]init];
    [_voiceButton setFrame:CGRectMake(0, 0,self.bounds.size.width / 2 , 120)];
    [containRightView addSubview:_voiceButton];
    [_voiceButton setImage:[UIImage imageNamed:@"xianxinghuatong-2.png"] forState:UIControlStateNormal];
    //tableview要改
    
    _tempArray = [[NSMutableArray alloc]initWithObjects:@"干垃圾", @"湿垃圾", @"有害垃圾", @"可回收垃圾", nil];
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 120;
    }
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"firstSonIdentifier" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.headImage.image = nil;
    cell.headTitileLabel.text = nil;
    if (indexPath.row != 0) {
        cell.headTitileLabel.text = [NSString stringWithFormat:@"%@",_tempArray[indexPath.row - 1]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 2) {
        cell.headImage.image = [UIImage imageNamed:@"icon_garbage_wet.png"];
    } else if (indexPath.row == 1) {
        cell.headImage.image = [UIImage imageNamed:@"icon_garbage_dry.png"];
    } else if (indexPath.row == 3) {
        cell.headImage.image = [UIImage imageNamed:@"icon_garbage_harmful.png"];
    } else if (indexPath.row == 4) {
        cell.headImage.image = [UIImage imageNamed:@"logo.png"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickDry" object:nil];
    }
    if (indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickWet" object:nil];
    }
    if (indexPath.row == 3) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHarmful" object:nil];
    }
    if (indexPath.row == 4) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickCycle" object:nil];
    }
}
@end
