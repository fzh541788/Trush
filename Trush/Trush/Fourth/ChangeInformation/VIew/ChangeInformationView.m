//
//  ChangeInformationView.m
//  Trush
//
//  Created by young_jerry on 2021/5/8.
//

#import "ChangeInformationView.h"
#import "ChangeInformationTableViewCell.h"

@implementation ChangeInformationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_tableView];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView registerClass:[ChangeInformationTableViewCell class] forCellReuseIdentifier:@"changeInformationIdentifier"];
    
    _tempArray = [[NSMutableArray alloc]initWithObjects:@"账号", @"昵称", @"个性签名", @"性别", @"学习阶段",nil];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _secondTempArray = [[NSMutableArray alloc]initWithObjects:_phone,_name,_msg,_sex,_stage, nil];
    
    ChangeInformationTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"changeInformationIdentifier" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",_tempArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.informationLabel.text = [NSString stringWithFormat:@"%@",_secondTempArray[indexPath.row]];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickName" object:nil];
    }
    if (indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickMsg" object:nil];
    }
    if (indexPath.row == 3) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickSex" object:nil];
    }
    if (indexPath.row == 4) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickStage" object:nil];
    }
}


@end
