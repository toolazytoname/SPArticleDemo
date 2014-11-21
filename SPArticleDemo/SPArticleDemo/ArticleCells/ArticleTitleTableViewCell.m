//
//  ArticleTitleTableViewCell.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/21.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ArticleTitleTableViewCell.h"
@interface ArticleTitleTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ArticleTitleTableViewCell
-(void)updateCellWithModel:(id)model
{
    if (model && [model isKindOfClass:[NSString class]]) {
        self.titleLabel.text = model;
    }
}


@end
