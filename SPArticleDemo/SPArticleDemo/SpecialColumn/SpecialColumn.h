//
//  SpecialColumn.h
//  SPArticleDemo
//
//  Created by SINA on 14/12/9.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SpecialColumn : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * fansNum;
@property (nonatomic, retain) NSString * feedId;
@property (nonatomic, retain) NSString * pic;
@property (nonatomic, retain) NSString * stitle;
@property (nonatomic, retain) NSString * title;

@end
