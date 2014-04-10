//
//  NSDate+HPUtils.m
//  HPUtils
//
//  Created by Hervé PEROTEAU on 14/03/2014.
//  Copyright (c) 2014 Hervé PEROTEAU. All rights reserved.
//

#import "NSDate+HPUtils.h"

@implementation NSDate (HPUtils)

-(BOOL) sameDayWithDate:(NSDate *) date {
    
    NSCalendar *calendar = [NSCalendar new];

    NSDateComponents* c1 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                       fromDate:self];
    
    NSDateComponents* c2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                       fromDate:date];
    
    return (c1.year == c2.year && c1.month == c2.month && c1.day == c2.day);
}

-(BOOL) passedOverXMinuts:(NSInteger) minuts {

    NSTimeInterval interval = -1 * [self timeIntervalSinceNow];
    
    NSLog(@"Date:%@ timeIntervalSinceNow:%f", self, interval);
    
    return ( interval >= minuts * 60 );
}

-(NSDate *) dateAtZeroHour {
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self];
    
    NSDate *date =  [[calendar dateFromComponents:components] dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMT]];
    
    return date;
}

-(NSDate *) dateAtZeroHourTomorrow {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    NSDate *tomorrow = [calendar dateByAddingComponents:components
                                                 toDate:self
                                                options:0];
    
    return [tomorrow dateAtZeroHour];
}

-(NSDate *) dateAtZeroHourMinusXDays:(NSInteger)days {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1*days];
    
    NSDate *date = [calendar dateByAddingComponents:components
                                                 toDate:self
                                                options:0];
    
    return [date dateAtZeroHour];
}

- (NSInteger)daysUntilNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    
    NSInteger days = [difference day];
    
    return days;
}


@end
