//
//  ChangeInformationView.h
//  Trush
//
//  Created by young_jerry on 2021/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeInformationView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, copy) NSMutableArray *secondTempArray;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *stage;

@end

NS_ASSUME_NONNULL_END
