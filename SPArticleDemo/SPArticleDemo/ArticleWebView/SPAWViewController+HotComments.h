//
//  SPAWViewController+HotComments.h
//  SPArticleDemo
//
//  Created by SINA on 14/12/4.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPAWViewController.h"

@interface SPAWViewController (HotComments)
- (void)requestHotComments;
- (void)parseHotComments:(BaseDataRequest*)request;
@end
