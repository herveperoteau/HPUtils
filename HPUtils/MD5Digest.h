//
//  MD5Digest.h
//  HPUtils
//
//  Created by Hervé PEROTEAU on 11/12/2013.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Digest)
- (NSString*) md5Digest;
@end

@interface NSData (MD5Digest)
- (NSString*) md5Digest;
@end
