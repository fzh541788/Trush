//
//  ResultViewController.h
//  Trush
//
//  Created by young_jerry on 2021/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *name;
@property (nonatomic, strong) NSMutableArray *maybe;
@end

NS_ASSUME_NONNULL_END
