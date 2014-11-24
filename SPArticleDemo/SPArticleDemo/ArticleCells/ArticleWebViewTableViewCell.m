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
static CGFloat cellHeightStatic;

@interface ArticleWebViewTableViewCell()<SPAWViewControllerDelegate>
@property (nonatomic, retain) SPAWViewController *awViewController;
@end


@implementation ArticleWebViewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _awViewController = [[SPAWViewController alloc] initWithNibName:@"SPAWViewController" bundle:nil];
        [self.contentView addSubview:self.awViewController.view];
        self.awViewController.awViewControllerDelegate = self;
    }
    return  self;
}


-(void)updateCellWithModel:(id)model
{
    if (model && [model isKindOfClass:[NSString class]]) {
        if(!self.awViewController.urlParam)
        {
            self.awViewController.urlParam = model;
            [self.awViewController loadArticle];
        }
    }
}



+(CGFloat)cellHeight
{
    NSLog(@"cellHeightStatic:%f",cellHeightStatic);
    return cellHeightStatic;
}


- (void)layoutArticleFinished:(UIWebView *)webView SPAWViewController:(SPAWViewController *)AWViewController;
{
    cellHeightStatic = CGRectGetHeight(webView.frame);
    if (self.articleWebViewTableViewCellDelegate && [self.articleWebViewTableViewCellDelegate respondsToSelector:@selector(layoutArticleFinished:SPAWViewController:ArticleWebViewTableViewCell:)]) {
        [self.articleWebViewTableViewCellDelegate layoutArticleFinished:webView SPAWViewController:AWViewController ArticleWebViewTableViewCell:self];
    }
    
}
@end
