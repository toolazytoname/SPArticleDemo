//
//  OPUtility.m
//  NewsHD
//
//  Created by Sun Guanglei on 12-8-24.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import "OPUtility.h"
#import <string.h>
//#import "IASKSettingsReader.h"
#import <CommonCrypto/CommonDigest.h>

@implementation OPUtility

#pragma mark -
#pragma mark TimeFormat
+ (NSDate *)dateFromString:(NSString *)feedDateString
{
    //
    // Example of formatting the date string
    // "Tue, 16 Dec 2008 11:45:13 +0000"
    // to
    // "16. December 2008"
    //
    //
    // A formatter to create a date using the RFC2822 date of a RSS feed
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    // Note: We have to force the locale to "en_US" to avoid unexpected issues formatting data
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [inputFormatter setLocale: usLocale];
    SAFE_ARC_RELEASE(usLocale);
    // set the format based on an RFC2822 date format
    [inputFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    // create a NSDate object using the NSDateFormatter
    NSDate *formattedDate = [inputFormatter dateFromString: feedDateString];
    SAFE_ARC_RELEASE(inputFormatter);
    
    return formattedDate;
}

+ (NSInteger)timestampFromString:(NSString *)feedDateString
{
    NSDate *formattedDate = [OPUtility dateFromString:feedDateString];
    NSInteger timestamp = (NSInteger)[formattedDate timeIntervalSince1970];
    return timestamp;
}

+ (NSString *)standardTimeFromString:(NSString *)feedDateString
{
    NSDate *formattedDate = [OPUtility dateFromString:feedDateString];
    NSDateFormatter *outputFormatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [outputFormatter stringFromDate:formattedDate];
}

+ (NSString *)standardTimeFromStringWithoutSecond:(NSString *)feedDateString
{
    NSDate *formattedDate = [OPUtility dateFromString:feedDateString];
    NSDateFormatter *outputFormatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [outputFormatter stringFromDate:formattedDate];
}

+ (NSString *)standardTimeFromTimestamp:(NSUInteger)timestamp
{
    NSDate *formattedDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *outputFormatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [outputFormatter stringFromDate:formattedDate];
}

+ (NSString *)standardTimeFromTimestampWithoutSecond:(NSUInteger)timestamp
{
    NSDate *formattedDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *outputFormatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [outputFormatter stringFromDate:formattedDate];
}

#pragma mark -
+ (void)propertyFromDictionary:(NSDictionary *)dict forObject:(id)target propertyDict:(NSDictionary *)pdict
{
    [pdict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id val = [dict objectForKey:obj];
        if (val != nil && val != [NSNull null]) {
            [target setValue:val forKey:key];
        }
    }];
}

+ (NSString *)chanelFromURL:(NSString *)url
{
    NSRange fstDotRange = [url rangeOfString:@"."];
    if (fstDotRange.location != NSNotFound) {
        NSRange chanelRange;
        chanelRange.location = 0;
        if ([url hasPrefix:@"http://"]) {
            chanelRange.location = 7;
            chanelRange.length = fstDotRange.location - chanelRange.location;
        }
        return [url substringWithRange:chanelRange];
    }
    return nil;
}

+ (NSString *)gbkDataToUTF8Str:(NSData *)gbkData
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *dataStr = SAFE_ARC_AUTORELEASE([[NSString alloc] initWithData:gbkData encoding:enc]);
    return dataStr;
}

+ (NSString*)md5Hash:(NSString*)input {
    
    const char* str = [input UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02x",result[i]];
        
    }
    
    return ret;
}

@end
