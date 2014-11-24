//
//  VideoBaseTableViewCell.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/19.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "VideoBaseTableViewCell.h"

@implementation VideoBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithModel:(id)model
{
    
}
-(id)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    return self;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}
+(CGFloat)cellHeight
{
    return 0.0;
}
@end
