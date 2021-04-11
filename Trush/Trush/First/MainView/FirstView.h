//
//  FirstView.h
//  Trush
//
//  Created by young_jerry on 2020/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *pictureButton;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchButton;

@end

NS_ASSUME_NONNULL_END
