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
    
    _headImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_headImage];
    
    _headTitileLabel = [[UILabel alloc]init];
    _headTitileLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_headTitileLabel];
    
    _msgLabel = [[UILabel alloc]init];
    _msgLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_msgLabel];
    
    _headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_headImageButton];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(20, 20, 300, 50);
    _headImage.frame = CGRectMake(20, 50, 96, 96);
    _headImageButton.frame = CGRectMake(20, 50, 96, 96);
    _headTitileLabel.frame = CGRectMake(150, 50, 300, 50);
    _msgLabel.frame = CGRectMake(150, 100, 300, 50);
}
@end
