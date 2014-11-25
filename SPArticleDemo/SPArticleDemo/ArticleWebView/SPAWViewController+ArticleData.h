//
//  SPAWViewController+ArticleData.h
//  SPArticleDemo
//
//  Created by SINA on 14/11/25.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPAWViewController.h"

@interface SPAWViewController (ArticleData)
- (void)loadArticle;
- (void)loadSlide;
- (void)finished;
- (id)parseSilde:(NSString *)url;
- (void)layoutArticle;
- (void)readyForData;
- (void)layoutArticleFinished;
- (void)slideDataReady:(id)data;


@end
