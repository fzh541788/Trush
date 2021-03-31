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


@property (nonatomic, assign) CGFloat locationOne;
@property (nonatomic, assign) CGFloat locationTwo;

@property (nonatomic, assign) bool didSecondChange;

@end

NS_ASSUME_NONNULL_END
