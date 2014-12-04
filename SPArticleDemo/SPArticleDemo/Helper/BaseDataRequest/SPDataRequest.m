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




@implementation SPHotCommentDataRequest:SPBaseDataRequest

-(NSString *)getURL
{
    return @"http://comment5.news.sina.com.cn/page/info?newsid=6-12-7434951&page=1&group=0&oe=utf-8&format=json&channel=ty";
}

-(SPHTTPRequestMethod)getHttpRequestMethod
{
    return SPHTTPRequestMethodGET;
}

-(void)dataProcess
{
    [super dataProcess];
    if (self.resultDataDic && [self.resultDataDic isKindOfClass:[NSDictionary class]]) {
        id result = [self.resultDataDic objectForKeyNotNull:@"result"];
        if (result && [result isKindOfClass:[NSDictionary class]]) {
            id data = [result objectForKey:@"hot_list"];
            if (data && [data isKindOfClass:[NSArray class]]) {
                NSArray* dataArray = (NSArray*)data;
                self.resultDataDic = [NSMutableDictionary dictionaryWithObject:dataArray forKey:SPHotCommentKey];
            }
        }
    }

}

@end