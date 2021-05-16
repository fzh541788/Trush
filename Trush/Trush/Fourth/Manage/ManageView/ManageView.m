//
//  ManageView.m
//  Trush
//
//  Created by young_jerry on 2020/12/14.
//

#import "ManageView.h"
#import "ManageSonTableViewCell.h"
#import "FMDB.h"

@implementation ManageView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"NameAndPass.sqlite"];
    self.path = fileName;
    [self queryData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.tableView.bounds),0)];
    _tableView.tableFooterView = v;
    [self addSubview:_tableView];
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countNumber.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    ManageSonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ManageSonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.countNumber[indexPath.row];
    return cell;
}

- (void) queryData{
    FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
    NSLog(@"%@",self.path);
    if ([dataBase open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM t_agreeOrder"];
        // 2.遍历结果
        self.countNumber = [[NSMutableArray alloc]init];
        while ([resultSet next]) {
            NSString *bankStr = [resultSet stringForColumn:@"name"];
            [self.countNumber addObject:bankStr];
        }
        [dataBase close];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        FMDatabase *dataBase = [FMDatabase databaseWithPath:self.path];
        if ([dataBase open]) {
            BOOL result = [dataBase executeUpdate:@"delete from t_agreeOrder where name = ?",self->_countNumber[indexPath.row]];
            if (result) {
                //                NSLog(@"删除数据成功");
            } else {
                NSLog(@"删除数据失败");
            }
            [dataBase close];
        }
        //        dispatch_async(dispatch_get_main_queue(), ^{
        [self queryData];
        [self.tableView reloadData];
        //        });
        completionHandler (YES);
        
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
