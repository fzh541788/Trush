//
//  MyActivityIndicatorView.m
//  Trush
//
//  Created by young_jerry on 2021/4/22.
//

#import "MyActivityIndicatorView.h"

#define kWidth 375
#define KHeight 667

@implementation MyActivityIndicatorView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 菊花背景的大小
        self.frame = CGRectMake(self.bounds.size.width / 2 - 50, self.bounds.size.height / 2 - 100, 100, 100);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 80, 40)];
        label.text = @"loading...";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
