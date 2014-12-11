//
//  SPSpecialColumnActionCell.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnActionCell.h"
#import "SPSpecialColumnModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+ITTAdditions.h"

@interface SPSpecialColumnActionCell()
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *specialColumnButton;

@end
@implementation SPSpecialColumnActionCell

-(void)updateCellWithModule:(id)module
{
    if (module && [module isKindOfClass:[SPSpecialColumnModel class]]) {
        SPSpecialColumnModel *specialColumnModule = (SPSpecialColumnModel *)module;
        [self.iconImage setImageWithURL:[NSURL URLWithString:specialColumnModule.pic]];
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.width/2;
        self.mainTitleLabel.text = specialColumnModule.title;
        self.subTitleLabel.text = specialColumnModule.desc;
        
        
    }
}



+(CGFloat)getCellHeight
{
    return 70.0f;
}
@end
