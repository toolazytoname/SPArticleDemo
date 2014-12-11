//
//  SPSpecialColumnCoreDataManager.h
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPSpecialColumnUtilDelegate <NSObject>



@end


@interface SPSpecialColumnUtil : NSObject

@property(nonatomic,strong) id<SPSpecialColumnUtilDelegate> specialColumnUtilDelegate;
+(id)shareInstance;
/**
 *  同步本地数据到服务器
 */
-(void)syncLocalToServer;












@property(nonatomic,assign) BOOL isLoggedIn;
@property(nonatomic,retain) NSString *token;
@property(nonatomic,retain) NSString *userId;
@property(nonatomic,retain) NSString *weiboToken;
@end
