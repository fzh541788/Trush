//
//  AnalyseView.h
//  Trush
//
//  Created by young_jerry on 2020/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalyseView : UIView

@property (nonatomic, strong) NSArray *pieDataArray;

@property (nonatomic,strong) NSMutableArray *colorArray;

@property (nonatomic,assign) BOOL showPercentage;
@property (nonatomic,strong) NSArray *pieDataNameArray;
@property (nonatomic,copy) NSString *pieDataUnit;

//v与c的联系 由于没有tableview 所以发现没办法通过之前tableview刷新的办法进行来进行传递值 学习到了这个方法 通过initwithframe方法传递一个属性 之前没有考虑过这样写
- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
