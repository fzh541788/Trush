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
    [self viewOfAnalyse:dataArray];
    return self;
}

- (void)viewOfAnalyse:(nonnull NSArray *)dataArray {
    self.pieDataArray = dataArray;
    self.pieDataNameArray = [[NSArray alloc]initWithObjects:@"干垃圾",@"湿垃圾",@"可回收垃圾",@"有害垃圾",nil];
    
    UIView *pieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
    pieView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - 10);
    pieView.backgroundColor = self.backgroundColor;//[UIColor whiteColor];
    pieView.tag = 101;
    [self addSubview:pieView];
    
    CGFloat radius = 120;//pieView.bounds.size.width > pieView.bounds.size.height ? pieView.bounds.size.height / 2 : pieView.bounds.size.width / 2;
    
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
        NSLog(@"%f",total);
        NSLog(@"%@",str);
    }
    
    NSArray *arr = @[@"#308ff7",@"#fbca58",@"#f5447d",@"#a020f0",@"#00ffff",@"#00ff00"];
    self.colorArray = [NSMutableArray arrayWithArray:arr];
    
    //标注
    CGFloat startAngle_p = 90;
    for (int i = 0; i < self.pieDataArray.count; i++) {
        NSString *num = self.pieDataArray[i];
        CGFloat angle = startAngle_p - [num floatValue] / 2 / total * 360;
        CGPoint pointInCenter = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) andAngle:angle andRadius:radius];
        CGPoint pointInCenter_2 = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) andAngle:angle andRadius:radius + radius / 10];
        CGPoint pointAtLabel;
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            pointAtLabel = CGPointMake(pointInCenter_2.x + radius / 4, pointInCenter_2.y);
        } else { // 偏左侧
            pointAtLabel = CGPointMake(pointInCenter_2.x - radius / 4, pointInCenter_2.y);
        }
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:pointInCenter];
        [linePath addLineToPoint:pointInCenter_2];
        [linePath addLineToPoint:pointAtLabel];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 0.5;
        layer.strokeColor = [self colorWithHexString:@"#00009C"].CGColor;
        layer.fillColor = nil;
        layer.path = linePath.CGPath;
        [self.layer addSublayer:layer];
        
        UILabel *lblMark = [[UILabel alloc] init];
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            lblMark.bounds = CGRectMake(0, 0, pieView.bounds.size.width - pointAtLabel.x - 2, 12);
        } else { // 偏左侧
            lblMark.bounds = CGRectMake(0, 0, pointAtLabel.x - 2, 12);
        }
        lblMark.textColor = [self colorWithHexString:@"#404040"];
        lblMark.font = [UIFont systemFontOfSize:10];
        lblMark.numberOfLines = 2;
        if (self.showPercentage) {
            NSString *num = self.pieDataArray[i];
            if (self.pieDataNameArray.count == 0 || self.pieDataNameArray.count != self.pieDataArray.count) {
                lblMark.text = [NSString stringWithFormat:@"%.2f%%",[num floatValue] / total * 100];
            } else {
                lblMark.text = [NSString stringWithFormat:@"%@:%.2f%%",self.pieDataNameArray[i],[num floatValue] / total * 100];
            }
        } else {
            if (!self.pieDataUnit) {
                self.pieDataUnit = @"次";
            }
            if (self.pieDataNameArray.count == 0 ) {
                lblMark.text = [NSString stringWithFormat:@"%@%@",self.pieDataArray[i],self.pieDataUnit];
            } else {
                lblMark.text = [NSString stringWithFormat:@"%@:%@%@",self.pieDataNameArray[i],self.pieDataArray[i],self.pieDataUnit];
            }
        }
        //        if (!self.pieDataUnit) {
        //            self.pieDataUnit = @"";
        //        }
        //        lblMark.text = [NSString stringWithFormat:@"%@:%@%@",self.legendNameArray[i],self.pieDataArray[i],self.pieDataUnit];
        [lblMark sizeToFit];
        [self addSubview:lblMark];
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            lblMark.center = CGPointMake(pointAtLabel.x + lblMark.bounds.size.width / 2 + 2, pointAtLabel.y);
        } else { // 偏左侧
            lblMark.center = CGPointMake(pointAtLabel.x - lblMark.bounds.size.width / 2 - 2, pointAtLabel.y);
        }
        
        startAngle_p = startAngle_p - [num floatValue] / total * 360 ;
    }
    
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

- (CGPoint)caculatePointAtCircleWithCenter:(CGPoint)center andAngle:(CGFloat)angle andRadius:(CGFloat)radius {
    CGFloat x = radius * cosf(angle * M_PI / 180);
    CGFloat y = radius * sinf(angle * M_PI / 180);
    return CGPointMake(center.x + x, center.y - y);
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
