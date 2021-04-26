//
//  FirstTableViewCell.m
//  Trush
//
//  Created by young_jerry on 2021/4/11.
//

#import "FirstTableViewCell.h"
#import "Masonry.h"

@implementation FirstTableViewCell

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
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_titleLabel];
    
    _headImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_headImage];
    
    _headTitileLabel = [[UILabel alloc]init];
    _headTitileLabel.font = [UIFont systemFontOfSize:19];
    [self.contentView addSubview:_headTitileLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(100);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [_headTitileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(100);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}
@end
