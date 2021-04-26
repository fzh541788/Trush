//
//  SearchView.h
//  Trush
//
//  Created by young_jerry on 2020/12/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotSearchArray;
@end

NS_ASSUME_NONNULL_END
