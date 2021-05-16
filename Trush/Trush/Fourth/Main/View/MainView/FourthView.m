//
//  FourthView.m
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import "FourthView.h"
#import "FourthSonTableViewCell.h"
#import "UIImageView+WebCache.h"
//后面可以将数据库中的东西变为与后台接口对接的部分

@implementation FourthView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView registerClass:[FourthSonTableViewCell class] forCellReuseIdentifier:@"fourthSonIdentifier"];
    
    _tempArray = [[NSMutableArray alloc]initWithObjects:@"数据分析", @"个人信息", @"修改密码", @"系统通知", @"关于",nil];

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 210;
    }
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FourthSonTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"fourthSonIdentifier" forIndexPath:indexPath];
    cell.headImage.image = nil;
    cell.headTitileLabel.text = nil;
    cell.titleLabel.text = nil;
    cell.titleLabel.textColor = [UIColor blackColor];
    cell.msgLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_img]]];
        cell.headTitileLabel.text = _name;
        cell.msgLabel.text = _msg;
        [cell.headImageButton addTarget:self action:@selector(pressHeadImage) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"                                      退出账号";
        cell.titleLabel.textColor = [UIColor redColor];
    } else {
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",_tempArray[indexPath.row - 1]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickAnalyse" object:nil];
    }
    if (indexPath.row == 4) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickLookInformation" object:nil];
    }
    if (indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickChangeInformation" object:nil];
    }
    if (indexPath.row == 3) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickChange" object:nil];
    }
    if (indexPath.row == 5) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHelp" object:nil];
    }
    if (indexPath.row == 6) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickQuit" object:nil];
    }
}

- (void)pressHeadImage {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"headImageView" object:nil];
}

@end
