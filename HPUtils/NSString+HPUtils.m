//
//  NSString+HPUtils.m
//  HPUtils
//
//  Created by Hervé PEROTEAU on 12/02/2014.
//  Copyright (c) 2014 Hervé PEROTEAU. All rights reserved.
//

#import "NSString+HPUtils.h"

@implementation NSString (HPUtils)


-(NSString *) stringByStrippingHTML {
    
    NSRange r;
    
    NSString *s = [self copy];
    
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    return s;
}

@end
