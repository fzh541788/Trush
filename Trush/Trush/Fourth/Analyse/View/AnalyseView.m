//
//  AnalyseView.m
//  Trush
//
//  Created by young_jerry on 2020/12/16.
//

#import "AnalyseView.h"

@implementation AnalyseView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(nonnull NSArray *)dataArray {
    self = [super initWithFrame:frame];
    self.pieDataArray = dataArray;

    UIView *pieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
    pieView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    pieView.backgroundColor = self.backgroundColor;//[UIColor whiteColor];
    [self addSubview:pieView];
    
    CGFloat radius = 160;//pieView.bounds.size.width > pieView.bounds.size.height ? pieView.bounds.size.height / 2 : pieView.bounds.size.width / 2;
    
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) radius:radius / 2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.fillColor = [UIColor clearColor].CGColor;
    bgLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgLayer.strokeStart = 0;
    bgLayer.strokeEnd = 1;
    bgLayer.zPosition = 1;
    bgLayer.lineWidth = radius;
    bgLayer.path = bgPath.CGPath;
    
    float total = 0;
    for (NSString *str in self.pieDataArray) {
        total = total + [str floatValue];
    }
    
    NSArray *arr = @[@"#308ff7",@"#fbca58",@"#f5447d",@"#a020f0",@"#00ffff",@"#00ff00"];
    self.colorArray = [NSMutableArray arrayWithArray:arr];
    CGFloat startAngle = -M_PI_2;
        for (int i = 0; i < self.pieDataArray.count; i++) {
            NSString *num = self.pieDataArray[i];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path addArcWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) radius:radius startAngle:startAngle endAngle:startAngle + [num floatValue] / total * M_PI * 2 clockwise:YES];
            //        path.lineWidth = 10;// 线宽与半径相同
            [path addLineToPoint:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2)];// 圆心
            [[self colorWithHexString:self.colorArray[i]] setStroke];
            [[self colorWithHexString:self.colorArray[i]] setFill];
            [path stroke];
            [path fill];
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
    //        layer.lineWidth = 30;
            layer.strokeColor = [UIColor whiteColor].CGColor; // 描边颜色
            layer.fillColor = [self colorWithHexString:self.colorArray[i]].CGColor; // 背景填充色
            [pieView.layer addSublayer:layer];
            //通过这句话计算
            startAngle = startAngle + [num floatValue] / total * M_PI * 2 ;
        }
    pieView.layer.mask = bgLayer;
    
//     动画
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0;// 起始值
    strokeAnimation.toValue = @1;// 结束值
    strokeAnimation.duration = 1;// 动画持续时间
    strokeAnimation.repeatCount = 1;// 重复次数
    strokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnimation.removedOnCompletion = YES;
    [bgLayer addAnimation:strokeAnimation forKey:@"pieAnimation"];
    
    
    return self;
}

- (UIColor *)colorWithHexString:(NSString *)color {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
