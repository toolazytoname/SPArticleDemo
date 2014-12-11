//
//  SPDataRequest.h
//  SportsHD
//
//  Created by 李金龙 on 14-2-13.
//  Copyright (c) 2014年 lose.hero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseDataRequest.h"

/**
 获取正文详情页数据
 */
@interface SPArticleDataRequest : SPBaseDataRequest

@end


/**
 *  获取热门评论数据
 */
#define SPHotCommentKey @"SPHotCommentKey"
@interface SPHotCommentDataRequest : SPBaseDataRequest

@end

/**
 *  获取 订阅专栏列表
 */
#define SPSubscribeSpecialColumnKey @"SPSubscribeSpecialColumnKey"
@interface SPSubscribeSpecialColumnDataRequest : SPBaseDataRequest

@end

/**
 *  获取 推荐专栏列表
 */
#define  SPRecommendSpecialColumnKey @"SPRecommendSpecialColumnKey"
@interface SPRecommendSpecialColumnDataRequest : SPBaseDataRequest

@end

/**
 *  获取 专栏列表
 */
#define  SPManagerSpecialColumnKey @"SPManagerSpecialColumnKey"
@interface SPManagerSpecialColumnDataRequest : SPBaseDataRequest

@end




/**
 *  专栏 订阅操作
 */
#define SPSubscribeSpecialColumnActionKey @"SPSubscribeSpecialColumnActionKey"
@interface SPSubscribeSpecialColumnActionRequest : SPBaseDataRequest

@end

/**
 *  专栏 订阅增加计数操作
 */
#define SPSubscribeSpecialColumnAddCountActionKey @"SPSubscribeSpecialColumnAddCountActionKey"
@interface SPSubscribeSpecialColumnAddCountActionRequest : SPBaseDataRequest

@end

/**
 *  专栏，同步到
 */
#define SPSpecialColumnSyncLocalToServerKey @"SPSpecialColumnSyncLocalToServerKey"
@interface SPSpecialColumnSyncLocalToServerDataRequest :SPBaseDataRequest

@end


