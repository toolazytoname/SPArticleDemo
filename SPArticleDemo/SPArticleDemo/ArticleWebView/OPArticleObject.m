//
//  OPArticleObject.m
//  NewsHD
//
//  Created by Sun Guanglei on 12-8-7.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import "OPArticleObject.h"


@implementation OPArticleCommentInfo
@synthesize commentID;
@synthesize totalCount;
@synthesize qreplyCount;
@synthesize showCount;

/*
 {
 comment: "yes",
 commentid: "gn:1-1-25109061",
 total_count: 724,
 qreply_count: 637,
 show_count: 23
 */
+ (id)commentInfoWithDict:(NSDictionary *)aDict
{
    // 接口设计不规范，文章没有评论的时候，comment不是字典而是空字符，Orz、
    // 判断一下类型，避免出错。
    if (![aDict isKindOfClass:[NSDictionary class]]) {
//        OPLog(@"not dict");
        return nil;
    }
    
    OPArticleCommentInfo *comment = [[[OPArticleCommentInfo alloc] init] autorelease];
    
    if (comment) {
        comment.commentID   = [ aDict objectForKey:@"commentid"   ];
        comment.totalCount  = [[aDict objectForKey:@"total_count" ] unsignedIntValue];
        comment.qreplyCount = [[aDict objectForKey:@"qreply_count"] unsignedIntValue];
        comment.showCount   = [[aDict objectForKey:@"show_count"  ] unsignedIntValue];
    }
    
    return comment;
}

- (void)dealloc
{
    [commentID release];
    
    [super dealloc];
}

@end

@implementation OPArticleObject
@synthesize tag;
@synthesize pid;
@synthesize cid;
@synthesize type;
@synthesize articleID;
@synthesize title;
@synthesize titleEn;
@synthesize shortTitle;
@synthesize author;
@synthesize summary;
@synthesize date;
@synthesize image;
@synthesize images;
@synthesize url;
@synthesize source;
@synthesize content;
@synthesize related;
@synthesize video;
@synthesize userInfo;
@synthesize commentInfo;

@synthesize albumID;
@synthesize albumSID;
@synthesize reservedtag;


- (void)dealloc
{
    [articleID  release];
    [title      release];
    [titleEn    release];
    [shortTitle release];
    [author     release];
    [summary    release];
    [date       release];
    [image      release];
    [images     release];
    [url        release];
    [source     release];
    [video      release];
    [content    release];
    [related    release];
    [userInfo   release];
    [albumID    release];
    [albumSID   release];
    [commentInfo    release];
    [reservedtag release];
    
    [super      dealloc];
}

//+ (OPArticleType)typeFromString:(NSString *)aType
//{
//    if ([[aType lowercaseString] isEqualToString:@"text"]) {
//        return OPArticleNews;
//    }
//    else if ([[aType lowercaseString] hasSuffix:@"blog"]) {
//        return OPArticleBlog;
//    }
//    else if ([[aType lowercaseString] isEqualToString:@"slide"]) {
//        return OPArticleSlide;
//    }
//    else if ([[aType lowercaseString] hasSuffix:@"video"]) {
//        return OPArticleVideo;
//    }
//    else if ([[aType lowercaseString] hasSuffix:@"subject"]) {
//        return OPArticleSubject;
//    }
//    else if ([[aType lowercaseString] hasSuffix:@"bbs"]) {
//        return OPArticleBBS;
//    }
//    
//    return OPArticleNews;
//}
/*
 0 => 'text',
 1 => 'subject',
 2 => 'video',
 3 => 'slide',
 4 => 'blog',
 5 => 'weibo',
 6 => 'bbs'
 */
+ (OPArticleType)typeFromString:(NSString *)aType
{
    if ([aType intValue] == 0) { //[[aType lowercaseString] isEqualToString:@"0"]) {
        return OPArticleNews;
    }
    else if ([aType intValue] == 4) {//[[aType lowercaseString] hasSuffix:@"4"]) {
        return OPArticleBlog;
    }
    else if ([aType intValue] == 3) {//([[aType lowercaseString] isEqualToString:@"3"]) {
        return OPArticleSlide;
    }
    else if ([aType intValue] == 2) {//([[aType lowercaseString] hasSuffix:@"2"]) {
        return OPArticleVideo;
    }
    else if ([aType intValue] == 1) {//([[aType lowercaseString] hasSuffix:@"1"]) {
        return OPArticleSubject;
    }
    else if ([aType intValue] == 6) {//([[aType lowercaseString] hasSuffix:@"6"]) {
        return OPArticleBBS;
    }
    
    return OPArticleNews;
}


- (id)objectForKey:(NSString *)strKey
{
    return [self valueForKey:strKey];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
