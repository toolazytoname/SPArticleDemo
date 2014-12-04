//
//  SPAWViewController+HotComments.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/4.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPAWViewController+HotComments.h"

@implementation SPAWViewController (HotComments)
-(void)requestHotComments
{
    [self addRequest:[SPHotCommentDataRequest requestWithDelegate:self parameters:nil isUseCache:YES requestTag:4]];
}



- (void)parseHotComments:(BaseDataRequest*)request
{
    NSArray *hotListArray = [request.resultDataDic objectForKeyNotNull:SPHotCommentKey];
    if (hotListArray) {
        NSError *error;
        NSData *hotListArrayJsonData = [NSJSONSerialization dataWithJSONObject:hotListArray options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *hotListArrayString = [[NSString alloc] initWithData:hotListArrayJsonData encoding:NSUTF8StringEncoding];
            NSLog(@"hotListArrayString:%@",hotListArrayString);
            NSString *parseHotListHandle = [NSString stringWithFormat:@"parseHotComments(%@)",hotListArrayString];
            [self runJSFuncion:parseHotListHandle];
        }
    }

}

@end
