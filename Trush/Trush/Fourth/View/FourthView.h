//
//  FourthView.h
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FourthView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
