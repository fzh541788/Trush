//
//  MapViewController.h
//  Trush
//
//  Created by young_jerry on 2020/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

@property (nonatomic, strong) UIButton *buttomButton;
//@property (nonatomic, strong) UIScrollView *viewTest;
//@property (nonatomic, strong) UIScrollView *secondView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, assign) CGFloat locationOne;
@property (nonatomic, assign) CGFloat locationTwo;

@property (nonatomic, assign) bool didSecondChange;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, strong) UIImageView *trashImage;
@property (nonatomic, copy) NSMutableArray *trashImageScource;

@property (nonatomic, copy) NSMutableArray *tempLatitude;
@property (nonatomic, copy) NSMutableArray *tempLongitude;

@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END
