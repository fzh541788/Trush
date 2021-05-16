//
//  ChangeInformationTableViewCell.m
//  Trush
//
//  Created by young_jerry on 2021/5/12.
//

#import "ChangeInformationTableViewCell.h"

@implementation ChangeInformationTableViewCell

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
    
    _informationLabel = [[UILabel alloc]init];
    _informationLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_informationLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(20, 20, 300, 50);
    _headImage.frame = CGRectMake(20, 50, 96, 96);
    _informationLabel.frame = CGRectMake(140, 20, 300, 50);
}

@end
