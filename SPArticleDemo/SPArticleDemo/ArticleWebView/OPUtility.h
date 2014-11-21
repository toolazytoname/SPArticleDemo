//
//  OPUtility.h
//  NewsHD
//
//  Created by Sun Guanglei on 12-8-24.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPUtility : NSObject

// Usefull time format functions.
+ (NSDate *)dateFromString:(NSString *)feedDateString;
+ (NSInteger)timestampFromString:(NSString *)feedDateString;
+ (NSString *)standardTimeFromString:(NSString *)feedDateString;
+ (NSString *)standardTimeFromStringWithoutSecond:(NSString *)feedDateString;
+ (NSString *)standardTimeFromTimestamp:(NSUInteger)timestamp;
+ (NSString *)standardTimeFromTimestampWithoutSecond:(NSUInteger)timestamp;

+ (void)propertyFromDictionary:(NSDictionary *)dict forObject:(id)target propertyDict:(NSDictionary *)pdict;
+ (NSString *)chanelFromURL:(NSString *)url;
+ (NSString *)gbkDataToUTF8Str:(NSData *)gbkData;

+ (NSString*)md5Hash:(NSString*)input;

@end
