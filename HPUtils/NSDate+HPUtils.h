//
//  NSDate+HPUtils.h
//  HPUtils
//
//  Created by Hervé PEROTEAU on 14/03/2014.
//  Copyright (c) 2014 Hervé PEROTEAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HPUtils)

-(BOOL) sameDayWithDate:(NSDate *)date;
-(BOOL) passedOverXMinuts:(NSInteger)minuts;

-(NSDate *) dateAtZeroHour;
-(NSDate *) dateAtZeroHourTomorrow;
-(NSInteger) daysUntilNow;

-(NSDate *) dateAtZeroHourMinusXDays:(NSInteger)days;


@end
