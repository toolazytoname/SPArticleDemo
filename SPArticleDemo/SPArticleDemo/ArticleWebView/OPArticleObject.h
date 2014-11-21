//
//  OPArticleObject.h
//  NewsHD
//
//  Created by Sun Guanglei on 12-8-7.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    OPArticleNews = 0,      // 普通新闻
    OPArticleBlog,          // 博客
    OPArticleSlide,         // 图集
    OPArticleVideo,         // 视频
    OPArticleSubject,       // 专题
    OPArticleBBS            // 论坛帖子
}OPArticleType;

@interface OPArticleCommentInfo : NSObject

@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, assign) NSUInteger totalCount;
@property (nonatomic, assign) NSUInteger qreplyCount;
@property (nonatomic, assign) NSUInteger showCount;

+ (id)commentInfoWithDict:(NSDictionary *)aDict;

@end

@interface OPArticleObject : NSObject

@property (nonatomic, assign) NSInteger     tag;
@property (nonatomic, assign) NSInteger     pid;
@property (nonatomic, assign) NSInteger     cid;
@property (nonatomic, assign) OPArticleType type;
@property (nonatomic, strong) NSString      *articleID;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *titleEn;
@property (nonatomic, strong) NSString      *shortTitle;
@property (nonatomic, strong) NSString      *author;
@property (nonatomic, strong) NSString      *summary;
@property (nonatomic, strong) NSString      *date;
@property (nonatomic, strong) NSString      *image;
@property (nonatomic, strong) NSArray       *images;
@property (nonatomic, strong) NSString      *url;
@property (nonatomic, strong) NSString      *source;
@property (nonatomic, strong) NSString      *content;
@property (nonatomic, strong) NSArray       *related;
@property (nonatomic, strong) NSDictionary  *reservedtag;
@property (nonatomic, strong) NSDictionary  *video;
@property (nonatomic, strong) NSDictionary  *userInfo;
// 图集属性 sid: "2841", album_id: "26545"
@property (nonatomic, strong) NSString      *albumSID;
@property (nonatomic, strong) NSString      *albumID;

@property (nonatomic, strong) NSString      *ads_flag; //点播定向
@property (nonatomic, strong) NSString      *time_length; //播放时长

@property (nonatomic, strong) NSString      *live_flag; //直播定向
@property (nonatomic, strong) NSString      *game_num; //场次

@property (nonatomic, strong) OPArticleCommentInfo *commentInfo;

+ (OPArticleType)typeFromString:(NSString *)aType;

- (id)objectForKey:(NSString *)strKey;

@end
