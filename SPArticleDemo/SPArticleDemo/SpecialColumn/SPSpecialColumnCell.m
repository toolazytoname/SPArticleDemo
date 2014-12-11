//
//  SPSpecialColumnCell.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnCell.h"
#import "SPSpecialColumnModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+ITTAdditions.h"


@interface SPSpecialColumnCell()
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;


@end
@implementation SPSpecialColumnCell


-(void)updateCellWithModule:(id)module
{
    if (module && [module isKindOfClass:[SPSpecialColumnModel class]]) {
        SPSpecialColumnModel *specialColumnModule = (SPSpecialColumnModel *)module;
        [self.iconImage setImageWithURL:[NSURL URLWithString:specialColumnModule.pic]];
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.width/2;
        self.mainTitleLabel.text = specialColumnModule.title;
        self.subTitleLabel.text = specialColumnModule.desc;
        self.countLabel.text = [NSString stringWithFormat:@"%i", (int)specialColumnModule.fansNum];
        self.countLabel.backgroundColor = [UIColor orangeColor];
        self.countLabel.layer.masksToBounds = YES;
        self.countLabel.layer.cornerRadius = self.countLabel.width/2;
    }
}

+(CGFloat)getCellHeight
{
    return 70.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];
    
    // Configure the view for the selected state
}
@end
