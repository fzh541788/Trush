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

@property (nonatomic, strong) NSMutableArray *tempArray;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) UIButton *headImageButton;

@end

NS_ASSUME_NONNULL_END
