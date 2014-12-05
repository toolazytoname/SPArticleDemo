//
//  SPSpecialColumnModule.h
//
//  Created by 懒得起名  on 14/12/5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"



@interface SPSpecialColumnModule : SPBaseModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSArray *sideH;
@property (nonatomic, strong) NSArray *sideV;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *terminal;
@property (nonatomic, strong) NSString *isRecommend;
@property (nonatomic, strong) NSString *isWemedia;
@property (nonatomic, strong) NSString *stitle;
@property (nonatomic, assign) double fansNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
