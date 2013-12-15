//
//  UIImage+HPUtils.m
//  HPUtils
//
//  Created by Hervé PEROTEAU on 15/12/2013.
//  Copyright (c) 2013 Hervé PEROTEAU. All rights reserved.
//

#import "UIImage+HPUtils.h"

@implementation UIImage (HPUtils)

+(UIImage *) createBySuperpositionImageBottom:(UIImage *)bottom AndImageTop:(UIImage *)top {

    CGSize newSize = bottom.size;
    
    UIGraphicsBeginImageContext( newSize );
    
    [bottom drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    [top drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
