//
//  MyViewController.h
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : UIViewController

@property (nonatomic, strong) NSString *numberTestString;
@property (nonatomic, strong) NSString *passTestString;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) NSMutableArray *testArray;

NS_ASSUME_NONNULL_END

@end

