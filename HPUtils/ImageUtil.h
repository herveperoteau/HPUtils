//
//  ImageUtil.h
//  iFolio
//
//  Created by Hervé PEROTEAU on 04/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGContext.h>
#import <UIKit/UIKit.h>


#define SQUARED_THUMBNAIL_SIZE 80

@interface ImageUtil : NSObject {

}

+(void) razTimeImageWithImage;
+(void) logTimeImageWithImage;

+(UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(UIImage *) squareThumbnailImageWithImage:(UIImage *)imageMaster;
+(UIImage *) squareImageWithImage:(UIImage *)imageMaster; 
	
+(UIColor *) colorByName:(NSString *)nameColor;
+(UIImage *) makeRoundCornerImage:(UIImage*) img withPourcentRound:(NSInteger) pourcentRound;

// Analyse des pixels
+(void) razTimeCreateBitmapContext;
+(void) logTimeCreateBitmapContext;
+(void) razTimeComputeColor;
+(void) logTimeComputeColor;
+(NSArray *) getRGBAsFromImage:(UIImage *)image atX:(int)xx andY:(int)yy count:(int)count;

// Array of NSNumber : int value = (red << 24) | (green << 16) | (blue << 8) | alpha;
//
// id0 = couleur globale moyenne
// id1 = couleur moyenne quart haut gauche
// id2 = couleur moyenne quart haut droite
// id3 = couleur moyenne quart bas gauche
// id4 = couleur moyenne quart bas droite
//
+(NSArray *) getRGBA_AveragesFromImage:(UIImage *)image;
+(NSArray *) getRGBA_AveragesFromImage:(UIImage *)image AndOffsetPixelNotUsed:(NSInteger) notUsed;

+(unsigned char) getComponentFromRGBA:(int) value IdComponent:(NSInteger)idComponent;

+(UIColor *) colorFromRGBAValue:(int)value;

+(CGFloat) distanceBetweenRGBAColor:(int) color1 AndColor:(int)color2;

+(UIImage *) cropImage:(UIImage *)master inRect:(CGRect) rect;

+(UIImage *) tintImage:(UIImage *)master WithColor:(UIColor *)color;

+(UIImage *) tintImage:(UIImage *)master WithColor:(UIColor *)color fraction:(CGFloat)fraction;

// Sert a incruster du texte avec fond, sur une image
// Utiliser dans appli Hourra, et aussi dans le TwitPic de mosaic
+ (void) CGContextAddRoundedRectWithCtx:(CGContextRef) c rect:(CGRect) rect radiusCorner:(int) corner_radius;


@end
