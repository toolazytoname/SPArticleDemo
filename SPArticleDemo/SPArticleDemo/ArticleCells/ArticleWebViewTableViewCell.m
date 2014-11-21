//
//  ArticleWebViewTableViewCell.m
//  SPArticleDemo
//   显示webview的cell
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ArticleWebViewTableViewCell.h"
#import "SPAWViewController.h"

@interface ArticleWebViewTableViewCell()
@property (nonatomic, retain) SPAWViewController *awViewController;
@end


@implementation ArticleWebViewTableViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _awViewController = [[SPAWViewController alloc] initWithNibName:@"SPAWViewController" bundle:nil];
    [self.contentView addSubview:self.awViewController.view];
    return self;
}

-(void)updateCellWithModel:(id)model
{
    if (model && [model isKindOfClass:[NSString class]]) {
        self.awViewController.urlParam = model;
        [self.awViewController loadArticle];
    }
}

-(CGFloat)cellHeight
{
//    CGFloat height = CGRectGetHeight(self.awViewController.view.frame);
//    return height;
    return 100.0;
}
@end
