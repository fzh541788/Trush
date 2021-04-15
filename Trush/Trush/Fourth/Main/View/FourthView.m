//
//  FourthView.m
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import "FourthView.h"
#import "FourthSonTableViewCell.h"
//后面可以将数据库中的东西变为与后台接口对接的部分

@implementation FourthView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"NameAndPass.sqlite"];
    self.path = fileName;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
       FourthSonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (!cell) {
           cell = [[FourthSonTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       }
    if (indexPath.row == 0) {
        cell.headImage.image = [UIImage imageNamed:@"logo.png"];
        cell.headTitileLabel.text = @"复杂化";
        //这个image应该是从后台获取不同的头像及id姓名
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"数据分析";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"修改个人信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"管理账号信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"修改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"忘记密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"帮助";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 7) {
        cell.titleLabel.text = @"                                      退出账号";
        cell.titleLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickAnalyse" object:nil];
    }
    if (indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickChangeInformation" object:nil];
    }
    if (indexPath.row == 3) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickManage" object:nil];
    }
    if (indexPath.row == 4) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickChange" object:nil];
    }
    if (indexPath.row == 5) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickForget" object:nil];
    }
    if (indexPath.row == 6) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHelp" object:nil];
    }
    if (indexPath.row == 7) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickQuit" object:nil];
    }
}

@end
