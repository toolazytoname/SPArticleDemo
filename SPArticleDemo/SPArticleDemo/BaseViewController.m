//
//  BaseViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
#pragma mark Utils
-(void)addRequest:(BaseDataRequest *)request
{
    if (request && [request isKindOfClass:[BaseDataRequest class]])
    {
        if (!self.requestQueue) {
            NSLog(@"self.requestQueue 为 nil");
        }
        [self.requestQueue addObject:request];
    }
}

- (void) cancelAllRequests
{
    [self.requestQueue makeObjectsPerformSelector:@selector(cancel)];
    [self.requestQueue removeAllObjects];
}
- (void)requestDidStartLoad:(BaseDataRequest*)request
{}
- (void)requestDidFinishLoad:(BaseDataRequest*)request
{}
- (void)request:(BaseDataRequest*)request didFailLoadWithError:(NSError*)error
{}

@end
