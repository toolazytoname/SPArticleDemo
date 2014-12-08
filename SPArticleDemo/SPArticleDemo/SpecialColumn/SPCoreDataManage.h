//
//  SPCoreDataManage.h
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SPCoreDataManage : NSObject
@property(nonatomic,readonly) NSManagedObjectContext * appDataContext;
+(id)shareInstance;
@end
