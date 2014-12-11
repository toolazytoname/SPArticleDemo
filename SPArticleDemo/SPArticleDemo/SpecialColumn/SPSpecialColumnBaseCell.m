//
//  SPSpecialColumnBaseCell.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnBaseCell.h"

@implementation SPSpecialColumnBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])  owner:self options:nil] safeObjectAtIndex:0];
    return self;
}

-(void)updateCellWithModule:(id)module
{}
+(CGFloat)getCellHeight
{
    return 0.0;
}

@end
