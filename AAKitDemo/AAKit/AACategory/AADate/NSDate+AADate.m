//
//  NSDate+AADate.m
//  SXYZProject
//
//  Created by shiyuan on 16/7/31.
//  Copyright © 2016年 BoShang. All rights reserved.
//

#import "NSDate+AADate.h"
#import "NSUserDefaults+AAUserDefault.h"

@implementation NSDate (AADate)
+(NSDateFormatter *)aa_formatter {
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    });
    
    return formatter;
}

+ (void)printTime{
    NSDateFormatter *formatter = [self aa_formatter];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"time:%@",timeLocal);
}

@end
