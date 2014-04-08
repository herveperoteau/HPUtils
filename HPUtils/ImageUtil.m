//
//  ImageUtil.m
//  iFolio
//
//  Created by Hervé PEROTEAU on 04/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"

static NSTimeInterval timeComputeColor; 
static NSTimeInterval timeImageWithImage; 
static NSTimeInterval timeCreateBitmapContext;

@implementation ImageUtil

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
	NSDate *start = [NSDate date];

	UIGraphicsBeginImageContext(newSize);
	
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();  // menage via autorelease
	
	UIGraphicsEndImageContext();
	
	timeImageWithImage+=[start timeIntervalSinceNow];
	
	return newImage;
}

+ (UIImage *) squareThumbnailImageWithImage:(UIImage *)imageMaster {
    
    return [ImageUtil squareThumbnailImageWithImage:imageMaster
                                           WithSize:SQUARED_THUMBNAIL_SIZE];
}

+ (UIImage *) squareThumbnailImageWithImage:(UIImage *)imageMaster WithSize:(CGFloat)size {
	
	UIImage *result = [ImageUtil squareImageWithImage:imageMaster];
	
	if (result.size.width > size) {
        
		CGSize sizeSquaredThumbnail = CGSizeMake(size, size);
		
		result = [ImageUtil imageWithImage:result scaledToSize:sizeSquaredThumbnail];
	}
    
	return result;
}


+ (UIImage *) squareImageWithImage:(UIImage *)imageMaster {

	CGSize sizeMaster = imageMaster.size;

	if (sizeMaster.width == sizeMaster.height) {
		
		return imageMaster;   // deja en carré
	}
		
	CGRect clipRect;
	
	if (sizeMaster.width < sizeMaster.height) {  // mode portrait
		
		clipRect.size.width = sizeMaster.width;
		clipRect.size.height = sizeMaster.width; 
		
		clipRect.origin.x = 0;
		clipRect.origin.y = (sizeMaster.height - sizeMaster.width) / 2;
	}
	else {   // mode paysage
		
		clipRect.size.width = sizeMaster.height;
		clipRect.size.height = sizeMaster.height; 
		
		clipRect.origin.x = (sizeMaster.width - sizeMaster.height) / 2;
		clipRect.origin.y = 0;
	}
	
	CGImageRef clipCGImageRef = CGImageCreateWithImageInRect (imageMaster.CGImage, clipRect);

	UIImage *img = [UIImage imageWithCGImage:clipCGImageRef];
	
	CGImageRelease (clipCGImageRef);
	
	return img;
}


+ (UIColor *) colorByName:(NSString *)nameColor {

	UIColor *color = nil;
	
	if ( [nameColor isEqualToString:@"darkGrayColor"] ) {
		  
		color = [UIColor darkGrayColor];
	}
	else if ( [nameColor isEqualToString:@"lightGrayColor"] ) {
		
		color = [UIColor lightGrayColor];
	}
	else if ( [nameColor isEqualToString:@"grayColor"] ) {
		
		color = [UIColor grayColor];
	}
	
	else if ( [nameColor isEqualToString:@"blackColor"] ) {
		
		color = [UIColor blackColor];
	}
	
	else if ( [nameColor isEqualToString:@"whiteColor"] ) {
		
		color = [UIColor whiteColor];
	}
	
	else if ( [nameColor isEqualToString:@"redColor"] ) {
		
		color = [UIColor redColor];
	}
	else if ( [nameColor isEqualToString:@"blueColor"] ) {
		
		color = [UIColor blueColor];
	}
	else if ( [nameColor isEqualToString:@"cyanColor"] ) {
		
		color = [UIColor cyanColor];
	}
	else if ( [nameColor isEqualToString:@"brownColor"] ) {
		
		color = [UIColor brownColor];
	}
	else if ( [nameColor isEqualToString:@"greenColor"] ) {
		
		color = [UIColor greenColor];
	}
	else if ( [nameColor isEqualToString:@"orangeColor"] ) {
		
		color = [UIColor orangeColor];
	}
	else if ( [nameColor isEqualToString:@"purpleColor"] ) {
		
		color = [UIColor purpleColor];
	}
	else if ( [nameColor isEqualToString:@"yellowColor"] ) {
		
		color = [UIColor yellowColor];
	}
	else if (nameColor != nil) {
	
		NSLog (@"ImageUtil.colorByName(%@) inconnue !!!", nameColor);
		
	}
	
	
	return color;
}

+ (void) CGContextAddRoundedRectWithCtx:(CGContextRef) c rect:(CGRect) rect radiusCorner:(int) corner_radius {
	
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	/* Begin! */
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	/* First corner */
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	/* Second corner */
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);
	
	/* Third corner */
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);
	
	/* Fourth corner */
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	/* Done */
	CGContextClosePath(c);
	
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+(UIImage *)makeRoundCornerImage:(UIImage*) img withPourcentRound:(NSInteger) pourcentRound
{
	
	UIImage * newImage = nil;
	
	UIImage *carre = [ImageUtil squareImageWithImage:img];
	
	if (nil != carre)
	{
		int w = carre.size.width;
		int h = w; //img.size.height;
		
		float ovalWidth = w / pourcentRound;
		//float ovalHeight = h / pourcentRound;
		
		/*
		if (ovalWidth < ovalHeight) {
		
			ovalHeight = ovalWidth;
		}
		else {
		
			ovalWidth = ovalHeight;
		}
		 */
		
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
		
		CGContextBeginPath(context);
		CGRect rect = CGRectMake(0, 0, carre.size.width, carre.size.height);
		addRoundedRectToPath(context, rect, ovalWidth, ovalWidth);
		CGContextClosePath(context);
		CGContextClip(context);
		
		CGContextDrawImage(context, CGRectMake(0, 0, w, h), carre.CGImage);
		
		CGImageRef imageMasked = CGBitmapContextCreateImage(context);
		CGContextRelease(context);
		CGColorSpaceRelease(colorSpace);

		newImage = [UIImage imageWithCGImage:imageMasked]; 
		
		CGImageRelease(imageMasked);
	}
	
    return newImage;
}

//
// Récupérer sur cette url http://fr.w3support.net/index.php?db=so&id=448125
// Permet d'acceder aux pixels d'une image
//
+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count 
{ 
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count]; 
   
	// First get the image into your data buffer 
    CGImageRef imageRef = [image CGImage]; 
    NSUInteger width = CGImageGetWidth(imageRef); 
    NSUInteger height = CGImageGetHeight(imageRef); 
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
    unsigned char *rawData = malloc(height * width * 4); 
    NSUInteger bytesPerPixel = 4; 
    NSUInteger bytesPerRow = bytesPerPixel * width; 
    NSUInteger bitsPerComponent = 8; 
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, 
												 bitsPerComponent, bytesPerRow, colorSpace, 
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big); 
    CGColorSpaceRelease(colorSpace); 
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef); 
    CGContextRelease(context); 
    // Now your rawData contains the image data in the RGBA8888 pixel format. 
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel; 
    for (int ii = 0 ; ii < count ; ++ii) 
    { 
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0; 
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0; 
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0; 
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0; 
        byteIndex += 4; 
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha]; 
        [result addObject:acolor]; 
    } 
	free(rawData); 
	return result; 
} 

+(void) razTimeComputeColor {

	timeComputeColor = 0;
}

+(void) logTimeComputeColor {
	
	NSLog (@"timeComputeColor=%f", timeComputeColor);
	
}

+(void) razTimeCreateBitmapContext{
	
	timeCreateBitmapContext = 0;
}

+(void) logTimeCreateBitmapContext {
	
	NSLog (@"timeCreateBitmapContext=%f", timeCreateBitmapContext);
	
}

+(void) razTimeImageWithImage {
	
	timeImageWithImage = 0;
}

+(void) logTimeImageWithImage {
	
	NSLog (@"timeImageWithImage=%f", timeImageWithImage);
	
}

+(NSArray *) getRGBA_AveragesFromImage:(UIImage *)image {

	return [ImageUtil getRGBA_AveragesFromImage:image AndOffsetPixelNotUsed:0];
}

// NSNumber : int value = (red << 24) | (green << 16) | (blue << 8) | alpha;
//
// id0 = couleur globale moyenne
// id1 = couleur moyenne quart haut gauche
// id2 = couleur moyenne quart haut droite
// id3 = couleur moyenne quart bas gauche
// id4 = couleur moyenne quart bas droite
//

+(NSArray *) getRGBA_AveragesFromImage:(UIImage *)image AndOffsetPixelNotUsed:(NSInteger) notUsed {
		
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:100]; 

	// First get the image into your data buffer 
    CGImageRef imageRef = [image CGImage]; 
	
    NSUInteger width = CGImageGetWidth(imageRef); 
    NSUInteger height = CGImageGetHeight(imageRef); 
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
	
    unsigned char *rawData = malloc(height * width * 4); 
    
	NSUInteger bytesPerPixel = 4; 
    NSUInteger bytesPerRow = bytesPerPixel * width; 
    NSUInteger bitsPerComponent = 8; 
    
	NSDate *start = [NSDate date];
	CGContextRef context = CGBitmapContextCreate(rawData, width, height, 
												 bitsPerComponent, bytesPerRow, colorSpace, 
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big); 
    CGColorSpaceRelease(colorSpace); 
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef); 
    CGContextRelease(context); 
	
	timeCreateBitmapContext+= [start timeIntervalSinceNow];
    
	start = [NSDate date];

	// Now your rawData contains the image data in the RGBA8888 pixel format. 
    
	NSInteger cptPix=0;
	NSInteger cptPixHG=0;
	NSInteger cptPixHD=0;
	NSInteger cptPixBG=0;
	NSInteger cptPixBD=0;

	NSInteger sommeValuePix_r=0;
	NSInteger sommeValuePixHG_r=0;
	NSInteger sommeValuePixHD_r=0;
	NSInteger sommeValuePixBG_r=0;
	NSInteger sommeValuePixBD_r=0;
	
	NSInteger sommeValuePix_g=0;
	NSInteger sommeValuePixHG_g=0;
	NSInteger sommeValuePixHD_g=0;
	NSInteger sommeValuePixBG_g=0;
	NSInteger sommeValuePixBD_g=0;
	
	NSInteger sommeValuePix_b=0;
	NSInteger sommeValuePixHG_b=0;
	NSInteger sommeValuePixHD_b=0;
	NSInteger sommeValuePixBG_b=0;
	NSInteger sommeValuePixBD_b=0;
	
	NSInteger demiWidth = width/2;
	NSInteger demiHeight = height/2;
	
	for (int x=0; x<width; x=x+1+notUsed) {

		for (int y=0; y<height; y=y+1+notUsed) {

			int byteIndex = (bytesPerRow * y) + x * bytesPerPixel; 

			unsigned char red   = rawData[byteIndex]; 
			unsigned char green = rawData[byteIndex + 1]; 
			unsigned char blue  = rawData[byteIndex + 2]; 
			unsigned char alpha = rawData[byteIndex + 3]; 
			
			int value = (red << 24) | (green << 16) | (blue << 8) | alpha;
			
			if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
				
				NSLog (@"ImageUtil.getRGBA_AveragesFromImage pixel (%d, %d) r:%d g:%d b=%d a:%d => %u", x, y, red, green, blue, alpha, value); 

				NSLog (@"=> value=%u r:%u", value, [ImageUtil getComponentFromRGBA:value IdComponent:0]);
				NSLog (@"=> value=%u g:%u", value, [ImageUtil getComponentFromRGBA:value IdComponent:1]);
				NSLog (@"=> value=%u b:%u", value, [ImageUtil getComponentFromRGBA:value IdComponent:2]);
				NSLog (@"=> value=%u a:%u", value, [ImageUtil getComponentFromRGBA:value IdComponent:3]);
			}
			
			cptPix++;
			
			sommeValuePix_r+=red;
			sommeValuePix_g+=green;
			sommeValuePix_b+=blue;
			
			if (x < demiWidth) {   // motié gauche
				
				if (y < demiHeight) {   // quart haut
					
					cptPixHG++;
					
					sommeValuePixHG_r+=red;
					sommeValuePixHG_g+=green;
					sommeValuePixHG_b+=blue;
					
				}
				else {	// quart bas
					
					cptPixBG++;
					
					sommeValuePixBG_r+=red;
					sommeValuePixBG_g+=green;
					sommeValuePixBG_b+=blue;
					
				}
			}
			else {    // moitié droite
				
				if (y < demiHeight) {   // quart haut
					
					cptPixHD++;
					
					sommeValuePixHD_r+=red;
					sommeValuePixHD_g+=green;
					sommeValuePixHD_b+=blue;
					
				}
				else {	// quart bas
					
					cptPixBD++;
					
					sommeValuePixBD_r+=red;
					sommeValuePixBD_g+=green;
					sommeValuePixBD_b+=blue;
					
				}
			}
		}		
	}

	// id0 = couleur globale moyenne
	// id1 = couleur moyenne quart haut gauche
	// id2 = couleur moyenne quart haut droite
	// id3 = couleur moyenne quart bas gauche
	// id4 = couleur moyenne quart bas droite
	
	// ---- Couleur moyenne 
	
	unsigned char r = 0;
	unsigned char g = 0;
	unsigned char b = 0;
	unsigned char a = 255;
	
	if (cptPix > 0) {
		
		r = (sommeValuePix_r / cptPix);
		g = (sommeValuePix_g / cptPix);
		b = (sommeValuePix_b / cptPix);
	}
	
	int v = (r << 24) | (g << 16) | (b << 8) | a;

	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
	
		NSLog (@"===> ImageUtil.getRGBA_AveragesFromImage Moyenne r:%u g:%u b=%u a:%u => %u", r, g, b, a, v); 
	}
	
	NSNumber *averagePix = [NSNumber numberWithInt:v];
	
	// ---- Couleur moyenne coin HG
	
	r = 0;
	g = 0;
	b = 0;
	a = 255;
	
	if (cptPixHG > 0) {
		
		r = (sommeValuePixHG_r / cptPixHG);
		g = (sommeValuePixHG_g / cptPixHG);
		b = (sommeValuePixHG_b / cptPixHG);
	}
	
	v = (r << 24) | (g << 16) | (b << 8) | a;
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.getRGBA_AveragesFromImage MoyenneHG r:%u g:%u b=%u a:%u => %u", r, g, b, a, v); 
	}
	
	NSNumber *averagePixHG = [NSNumber numberWithInt:v];
	
	// ---- Couleur moyenne coin HD
	
	r = 0;
	g = 0;
	b = 0;
	a = 255;
	
	if (cptPixHD > 0) {
		
		r = (sommeValuePixHD_r / cptPixHD);
		g = (sommeValuePixHD_g / cptPixHD);
		b = (sommeValuePixHD_b / cptPixHD);
	}
	
	v = (r << 24) | (g << 16) | (b << 8) | a;
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.getRGBA_AveragesFromImage MoyenneHD r:%u g:%u b=%u a:%u => %u", r, g, b, a, v); 
	}
	
	NSNumber *averagePixHD = [NSNumber numberWithInt:v];
	
	// ---- Couleur moyenne coin BG
	
	r = 0;
	g = 0;
	b = 0;
	a = 255;
	
	if (cptPixBG > 0) {
		
		r = (sommeValuePixBG_r / cptPixBG);
		g = (sommeValuePixBG_g / cptPixBG);
		b = (sommeValuePixBG_b / cptPixBG);
	}
	
	v = (r << 24) | (g << 16) | (b << 8) | a;
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.getRGBA_AveragesFromImage MoyenneBG r:%u g:%u b=%u a:%u => %u", r, g, b, a, v); 
	}
	
	NSNumber *averagePixBG = [NSNumber numberWithInt:v];
	
	// ---- Couleur moyenne coin BD
	
	r = 0;
	g = 0;
	b = 0;
	a = 255;
	
	if (cptPixBD > 0) {
		
		r = (sommeValuePixBD_r / cptPixBD);
		g = (sommeValuePixBD_g / cptPixBD);
		b = (sommeValuePixBD_b / cptPixBD);
	}
	
	v = (r << 24) | (g << 16) | (b << 8) | a;
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.getRGBA_AveragesFromImage MoyenneBG r:%u g:%u b=%u a:%u => %u", r, g, b, a, v); 
	}
		
	NSNumber *averagePixBD = [NSNumber numberWithInt:v];
		
	[result addObject:averagePix]; 
	[result addObject:averagePixHG]; 
	[result addObject:averagePixHD]; 
	[result addObject:averagePixBG]; 
	[result addObject:averagePixBD]; 
	
	free(rawData); 
	
	timeComputeColor+=[start timeIntervalSinceNow];
	
	return result;
}


+(unsigned char) getComponentFromRGBA:(int) value IdComponent:(NSInteger)idComponent {

	unsigned char result = 0;
		
	NSString *componantLabel = nil;
	
	if (idComponent == 0) {   // red
		
		componantLabel = @"red";
		result = (value >> 24);
	}
	else if (idComponent == 1) {   // gren
		
		componantLabel = @"green";
		result = (value >> 16);
	}
	else if (idComponent == 2) {   // blue
		
		componantLabel = @"blue";
		result = (value >> 8);
	}
	else if (idComponent == 3) {   // alpha
		
		componantLabel = @"alpha";
		result = value;
	}

	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.getComponentFromRGBA:%d IdComponent:%d(%@) => %u", value, idComponent, componantLabel, result);
	}

	
	return result;
}

+(UIColor *) colorFromRGBAValue:(int) value {

	CGFloat r = ((CGFloat) [ImageUtil getComponentFromRGBA:value IdComponent:0]) / 255;
	CGFloat g = ((CGFloat) [ImageUtil getComponentFromRGBA:value IdComponent:1]) / 255;
	CGFloat b = ((CGFloat) [ImageUtil getComponentFromRGBA:value IdComponent:2]) / 255;
	CGFloat a = ((CGFloat) [ImageUtil getComponentFromRGBA:value IdComponent:3]) / 255;
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
		
		NSLog (@"===> ImageUtil.colorFromRGBAValue: r=%f g=%f b=%f a=%f", r, g, b, a);
	}
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


+(CGFloat) distanceBetweenRGBAColor:(int) color1 AndColor:(int)color2 {

	unsigned char r1 = [ImageUtil getComponentFromRGBA:color1 IdComponent:0];
	unsigned char g1 = [ImageUtil getComponentFromRGBA:color1 IdComponent:1];
	unsigned char b1 = [ImageUtil getComponentFromRGBA:color1 IdComponent:2];
	
	unsigned char r2 = [ImageUtil getComponentFromRGBA:color2 IdComponent:0];
	unsigned char g2 = [ImageUtil getComponentFromRGBA:color2 IdComponent:1];
	unsigned char b2 = [ImageUtil getComponentFromRGBA:color2 IdComponent:2];
	
	float dr = (r1-r2)*(r1-r2);
	float dg = (g1-g2)*(g1-g2);
	float db = (b1-b2)*(b1-b2);
	
	CGFloat result = sqrt(dr+dg+db);
	
	if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FLAGLOG_LIBUTILGENERIC_IMAGEUTIL"] ) {
	
		NSLog (@"distanceBetweenRGBAColor (%u,%u,%u) (%u,%u,%u) = (%f,%f,%f) %f", r1,g1,b1,r2,g2,b2,dr,dg,db,result);
	}
	
	return result;
}

+(UIImage *) cropImage:(UIImage *)master inRect:(CGRect) rect {
	
	UIGraphicsBeginImageContext(rect.size);
	[master drawAtPoint:CGPointMake(-1*rect.origin.x, -1*rect.origin.y)];
	UIImage *croppedImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
		
	return croppedImg;
}

+(UIImage *) tintImage:(UIImage *)master WithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [ImageUtil tintImage:master
					  WithColor:color 
					   fraction:0.0]; // default to a fully tinted mask of the image.
}


+(UIImage *) tintImage:(UIImage *)master WithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			UIGraphicsBeginImageContextWithOptions([master size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		}
#else
		if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0) {
			UIGraphicsBeginImageContext([master size]);
		}
#endif
		CGRect rect = CGRectZero;
		rect.size = [master size];
		
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
		
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[master drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
		
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[master drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return image;
	}
	
	return master;
}




@end
