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
 *  获取专栏列表
 */
#define SPSpecialColumnKey @"SPSpecialColumnKey"
@interface SPSpecialColumnDataRequest : SPBaseDataRequest

@end

/**
 *  专栏 订阅
 */
#define SPSpecialColumnSubscribeKey
@interface SPSpecialColumnSubscribeDataRequest : SPBaseDataRequest

@end

