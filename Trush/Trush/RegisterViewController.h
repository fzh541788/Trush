//
//  RegisterViewController.h
//  Trush
//
//  Created by young_jerry on 2020/12/7.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) UITextField *enterTextFiled;
@property (nonatomic, strong) UITextField *registerTextFiled;

@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) FMDatabase *dataBase;

@end

NS_ASSUME_NONNULL_END
