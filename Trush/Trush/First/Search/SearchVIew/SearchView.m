//
//  SearchView.m
//  Trush
//
//  Created by young_jerry on 2020/12/2.
//

#import "SearchView.h"
#import "Masonry.h"
#import "SearchSonTableViewCell.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.906 alpha:1];
    _searchTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _searchTextField.layer.cornerRadius = 25.0f;
    [self addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_top).offset(160);
        make.size.mas_equalTo(CGSizeMake(400,50));
    }];
    [_searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIColor *color = [UIColor colorWithRed:0.6823529 green:0.6823529 blue:0.68627 alpha:1];
    _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入垃圾名称" attributes:@{NSForegroundColorAttributeName: color}];
    _searchTextField.textAlignment = NSTextAlignmentCenter;
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:@"搜索   " forState:UIControlStateNormal];
    [_searchButton setTintColor:[UIColor grayColor]];
    _searchTextField.rightViewMode = UITextFieldViewModeAlways;
    _searchTextField.rightView = _searchButton;
    
    _tableView = [[UITableView alloc]init];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.searchTextField.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SearchSonTableViewCell class] forCellReuseIdentifier:@"searchSonIdentifier"];
    [self addSubview:_tableView];
    
    _hotSearchArray = [[NSMutableArray alloc]initWithObjects:@"纸", @"肥皂", @"止痛药", @"公交卡", @"西瓜", @"香水", @"卫生纸", @"电池", nil];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _hotSearchArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchSonTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"searchSonIdentifier" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"猜你想搜:";
        cell.textLabel.font = [UIFont systemFontOfSize:25];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_hotSearchArray[indexPath.section - 1]];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section != 0) {
        _searchTextField.text = _hotSearchArray[indexPath.section - 1];
    }
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    if (indexPath.section != 0) {
        UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            [self->_hotSearchArray removeObject:self->_hotSearchArray[indexPath.section - 1]];
            [self.tableView reloadData];
            completionHandler (YES);
        }];
        deleteRowAction.backgroundColor = [UIColor redColor];
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
        return config;
    }
    return 0;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
