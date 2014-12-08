//
//  SPSpecialColumnHeaderView.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnHeaderView.h"

@interface SPSpecialColumnHeaderView()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SPSpecialColumnHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] safeObjectAtIndex:0];
    return self;
}

-(void)setHeaderTitle:(NSString *)titleString
{
    self.titleLabel.text = titleString;
}

+(CGFloat)getHeaderViewHeight
{
    return 73.0f;
}
@end
