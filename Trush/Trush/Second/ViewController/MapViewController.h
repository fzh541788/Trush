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
@property (nonatomic, strong) UIScrollView *viewTest;

@property (nonatomic, strong) UIButton *nearlyButton;
@property (nonatomic, strong) UIButton *delegtWayButton;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIButton *upButton;

@property (nonatomic, assign) CGFloat locationOne;
@property (nonatomic, assign) CGFloat locationTwo;

@end

NS_ASSUME_NONNULL_END
