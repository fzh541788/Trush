//
//  FourthSonTableViewCell.m
//  Trush
//
//  Created by young_jerry on 2020/12/14.
//

#import "FourthSonTableViewCell.h"

@implementation FourthSonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(20, 20, 300, 50);
}
@end
