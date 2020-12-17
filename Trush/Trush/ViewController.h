//
//  ViewController.h
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
@interface ViewController : UIViewController

@property (nonatomic, strong) UITextField *enterTextFiled;
@property (nonatomic, strong) UITextField *registerTextFiled;

@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *wechatButton;

@property (nonatomic, strong) NSMutableArray *testName;
@property (nonatomic, strong) NSMutableArray *passName;

@property (nonatomic, copy) NSString *path;
//@property (nonatomic, strong) FMDatabase *dataBase;

@end

