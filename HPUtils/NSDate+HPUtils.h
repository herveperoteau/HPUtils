//
//  NSDate+HPUtils.h
//  HPUtils
//
//  Created by Hervé PEROTEAU on 14/03/2014.
//  Copyright (c) 2014 Hervé PEROTEAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HPUtils)

-(NSDate *) normalizedDate;
-(BOOL) sameDayWithDate:(NSDate *)date;

@end
