//
//  SPDataRequest.m
//  SportsHD
//
//  Created by 李金龙 on 14-2-13.
//  Copyright (c) 2014年 lose.hero. All rights reserved.
//

#import "SPDataRequest.h"
#import "BaseDataRequest.h"
#import "NSDictionary+Safe.h"
#import "NSArray+Safe.h"
#import "DataModels.h"



@implementation SPArticleDataRequest:SPBaseDataRequest


-(NSString *)getURL
{
    return nil;
}

-(SPHTTPRequestMethod)getHttpRequestMethod
{
    return SPHTTPRequestMethodGET;
}

-(void)dataProcess
{
    [super dataProcess];
}
@end




