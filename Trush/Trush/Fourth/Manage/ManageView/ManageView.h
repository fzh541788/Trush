//
//  ManageView.h
//  Trush
//
//  Created by young_jerry on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSMutableArray *countNumber;

@end

NS_ASSUME_NONNULL_END
