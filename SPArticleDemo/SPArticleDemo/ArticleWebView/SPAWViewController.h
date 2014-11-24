//
//  SPAWViewController.h
//  Sports
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sina.com. All rights reserved.
//

#import "SPArtWebViewController.h"
@class SPAWViewController;
@protocol SPAWViewControllerDelegate<NSObject>
- (void)layoutArticleFinished:(UIWebView *)webView SPAWViewController:(SPAWViewController *)AWViewController;
@end

@interface SPAWViewController : SPArtWebViewController
@property (nonatomic, strong) NSString *articleData;

//传入参数
@property(nonatomic,strong) NSString *typeParam;
@property(nonatomic,strong) NSString *urlParam;
@property(nonatomic,strong) NSString *liveParam;


@property (nonatomic, strong) NSString *liveURL;
@property (nonatomic, assign) BOOL isVideoArticle;


@property(nonatomic, assign) id<SPAWViewControllerDelegate> awViewControllerDelegate;
- (void)loadArticle;
@end
