//
//  NSDate+HPUtils.m
//  HPUtils
//
//  Created by Hervé PEROTEAU on 14/03/2014.
//  Copyright (c) 2014 Hervé PEROTEAU. All rights reserved.
//

#import "NSDate+HPUtils.h"

@implementation NSDate (HPUtils)

-(NSDate *) normalizedDate
{
    NSCalendar *calendar = [NSCalendar new];
    
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:self];
    
    return [calendar dateFromComponents:components];
}


-(BOOL) sameDayWithDate:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar new];

    NSDateComponents* c1 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                       fromDate:self];
    
    NSDateComponents* c2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                       fromDate:date];
    
    return (c1.year == c2.year && c1.month == c2.month && c1.day == c2.day);
}

@end
