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
    
    NSDate *d1 = [self normalizedDate];
    NSDate *d2 = [date normalizedDate];
    return [d1 isEqualToDate:d2];
}

@end
