//
//  BaseViewController.h
//  SPArticleDemo
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseDataRequest.h"
#import "SPDataRequest.h"

@interface BaseViewController : UIViewController<DataRequestDelegate>

/**
 *  请求队列
 */
@property (nonatomic, retain) NSMutableArray *requestQueue;

/**
 *  请求网络数据
 *
 *  @param request request
 */
-(void)addRequest:(BaseDataRequest *)request;

/**
 *  取消网络请求
 */
- (void) cancelAllRequests;

@end
