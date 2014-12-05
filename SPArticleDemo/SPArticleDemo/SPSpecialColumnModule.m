//
//  SPSpecialColumnModule.m
//
//  Created by 懒得起名  on 14/12/5
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SPSpecialColumnModule.h"


NSString *const kSPSpecialColumnModuleFeedId = @"feed_id";
NSString *const kSPSpecialColumnModuleSideH = @"side_h";
NSString *const kSPSpecialColumnModuleSideV = @"side_v";
NSString *const kSPSpecialColumnModuleDesc = @"desc ";
NSString *const kSPSpecialColumnModulePic = @"pic";
NSString *const kSPSpecialColumnModuleTitle = @"title";
NSString *const kSPSpecialColumnModuleTerminal = @"terminal";
NSString *const kSPSpecialColumnModuleIsRecommend = @"is_recommend";
NSString *const kSPSpecialColumnModuleIsWemedia = @"is_wemedia";
NSString *const kSPSpecialColumnModuleStitle = @"stitle";
NSString *const kSPSpecialColumnModuleFansNum = @"fans_num";


@interface SPSpecialColumnModule ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SPSpecialColumnModule

@synthesize feedId = _feedId;
@synthesize sideH = _sideH;
@synthesize sideV = _sideV;
@synthesize desc = _desc;
@synthesize pic = _pic;
@synthesize title = _title;
@synthesize terminal = _terminal;
@synthesize isRecommend = _isRecommend;
@synthesize isWemedia = _isWemedia;
@synthesize stitle = _stitle;
@synthesize fansNum = _fansNum;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.feedId = [self objectOrNilForKey:kSPSpecialColumnModuleFeedId fromDictionary:dict];
            self.sideH = [self objectOrNilForKey:kSPSpecialColumnModuleSideH fromDictionary:dict];
            self.sideV = [self objectOrNilForKey:kSPSpecialColumnModuleSideV fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kSPSpecialColumnModuleDesc fromDictionary:dict];
            self.pic = [self objectOrNilForKey:kSPSpecialColumnModulePic fromDictionary:dict];
            self.title = [self objectOrNilForKey:kSPSpecialColumnModuleTitle fromDictionary:dict];
            self.terminal = [self objectOrNilForKey:kSPSpecialColumnModuleTerminal fromDictionary:dict];
            self.isRecommend = [self objectOrNilForKey:kSPSpecialColumnModuleIsRecommend fromDictionary:dict];
            self.isWemedia = [self objectOrNilForKey:kSPSpecialColumnModuleIsWemedia fromDictionary:dict];
            self.stitle = [self objectOrNilForKey:kSPSpecialColumnModuleStitle fromDictionary:dict];
            self.fansNum = [[self objectOrNilForKey:kSPSpecialColumnModuleFansNum fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feedId forKey:kSPSpecialColumnModuleFeedId];
    NSMutableArray *tempArrayForSideH = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sideH) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSideH addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSideH addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSideH] forKey:kSPSpecialColumnModuleSideH];
    NSMutableArray *tempArrayForSideV = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sideV) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSideV addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSideV addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSideV] forKey:kSPSpecialColumnModuleSideV];
    [mutableDict setValue:self.desc forKey:kSPSpecialColumnModuleDesc];
    [mutableDict setValue:self.pic forKey:kSPSpecialColumnModulePic];
    [mutableDict setValue:self.title forKey:kSPSpecialColumnModuleTitle];
    NSMutableArray *tempArrayForTerminal = [NSMutableArray array];
    for (NSObject *subArrayObject in self.terminal) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTerminal addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTerminal addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTerminal] forKey:kSPSpecialColumnModuleTerminal];
    [mutableDict setValue:self.isRecommend forKey:kSPSpecialColumnModuleIsRecommend];
    [mutableDict setValue:self.isWemedia forKey:kSPSpecialColumnModuleIsWemedia];
    [mutableDict setValue:self.stitle forKey:kSPSpecialColumnModuleStitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fansNum] forKey:kSPSpecialColumnModuleFansNum];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.feedId = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleFeedId];
    self.sideH = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleSideH];
    self.sideV = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleSideV];
    self.desc = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleDesc];
    self.pic = [aDecoder decodeObjectForKey:kSPSpecialColumnModulePic];
    self.title = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleTitle];
    self.terminal = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleTerminal];
    self.isRecommend = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleIsRecommend];
    self.isWemedia = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleIsWemedia];
    self.stitle = [aDecoder decodeObjectForKey:kSPSpecialColumnModuleStitle];
    self.fansNum = [aDecoder decodeDoubleForKey:kSPSpecialColumnModuleFansNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feedId forKey:kSPSpecialColumnModuleFeedId];
    [aCoder encodeObject:_sideH forKey:kSPSpecialColumnModuleSideH];
    [aCoder encodeObject:_sideV forKey:kSPSpecialColumnModuleSideV];
    [aCoder encodeObject:_desc forKey:kSPSpecialColumnModuleDesc];
    [aCoder encodeObject:_pic forKey:kSPSpecialColumnModulePic];
    [aCoder encodeObject:_title forKey:kSPSpecialColumnModuleTitle];
    [aCoder encodeObject:_terminal forKey:kSPSpecialColumnModuleTerminal];
    [aCoder encodeObject:_isRecommend forKey:kSPSpecialColumnModuleIsRecommend];
    [aCoder encodeObject:_isWemedia forKey:kSPSpecialColumnModuleIsWemedia];
    [aCoder encodeObject:_stitle forKey:kSPSpecialColumnModuleStitle];
    [aCoder encodeDouble:_fansNum forKey:kSPSpecialColumnModuleFansNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    SPSpecialColumnModule *copy = [[SPSpecialColumnModule alloc] init];
    
    if (copy) {

        copy.feedId = [self.feedId copyWithZone:zone];
        copy.sideH = [self.sideH copyWithZone:zone];
        copy.sideV = [self.sideV copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
        copy.pic = [self.pic copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.terminal = [self.terminal copyWithZone:zone];
        copy.isRecommend = [self.isRecommend copyWithZone:zone];
        copy.isWemedia = [self.isWemedia copyWithZone:zone];
        copy.stitle = [self.stitle copyWithZone:zone];
        copy.fansNum = self.fansNum;
    }
    
    return copy;
}


@end
