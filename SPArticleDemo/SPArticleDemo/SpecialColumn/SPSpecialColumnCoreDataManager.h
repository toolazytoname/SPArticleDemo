//
//  SPSpecialColumnCoreDataManager.h
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSpecialColumnCoreDataManager : NSObject
+(id)shareInstance;
-(NSArray *)getAll;
-(void)addSpecialColumnList:(NSArray *)specialColumnArray;
@end
