//
//  ArticleWebViewTableViewCell.h
//  SPArticleDemo
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "VideoBaseTableViewCell.h"
@class SPAWViewController;
@class ArticleWebViewTableViewCell;
@protocol ArticleWebViewTableViewCellDelegate <NSObject>
- (void)layoutArticleFinished:(UIWebView *)webView SPAWViewController:(SPAWViewController *)AWViewController ArticleWebViewTableViewCell:(ArticleWebViewTableViewCell *)ArticleWebViewTableViewCell;
@end

@interface ArticleWebViewTableViewCell : VideoBaseTableViewCell
@property (nonatomic, assign) id<ArticleWebViewTableViewCellDelegate> articleWebViewTableViewCellDelegate;

@end
