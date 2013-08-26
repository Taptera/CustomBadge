/*
 CustomBadge.m
 
*** Description: ***
 With this class you can draw a typical iOS badge indicator with a custom text on any view.
 Please use the allocator customBadgeWithString to create a new badge.
 In this version you can modfiy the color inside the badge (insetColor),
 the color of the frame (frameColor), the color of the text and you can
 tell the class if you want a frame around the badge.
 
 *** License & Copyright ***
 Created by Sascha Paulus www.spaulus.com on 04/2011. Version 2.0
 This tiny class can be used for free in private and commercial applications.
 Please feel free to modify, extend or distribution this class. 
 If you modify it: Please send me your modified version of the class.
 Please do not sell the source code solely and keep this text in
 your copyright section. Thanks.
 
 If you have any questions please feel free to contact me (open@spaulus.com).

 */


#import "CustomBadge.h"

@interface CustomBadge()
- (void) drawRoundedRectWithContext:(CGContextRef)context withRect:(CGRect)rect;
- (void) drawFrameWithContext:(CGContextRef)context withRect:(CGRect)rect;
@end

@implementation CustomBadge

@synthesize badgeText;
@synthesize badgeTextColor;
@synthesize badgeInsetColor;
@synthesize badgeFrameColor;
@synthesize badgeFrame;
@synthesize badgeCornerRoundness;
@synthesize badgeScaleFactor;
@synthesize badgeShining;

+ (CGFloat)sizeOfFontForString:(NSString *)string withScale:(CGFloat)scale
{
    CGFloat sizeOfFont = 13.5*scale;
    if (string.length<2) {
        sizeOfFont += sizeOfFont*0.20;
    }
    return sizeOfFont;
}

- (id) initWithAttributedString:(NSAttributedString *)badgeAttributedString withScale:(CGFloat)scale withShining:(BOOL)shining
{
	self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
	if(self!=nil) {
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
		self.badgeText = badgeAttributedString;
		self.badgeFrame = YES;
		self.badgeFrameColor = [UIColor whiteColor];
		self.badgeInsetColor = [UIColor redColor];
		self.badgeCornerRoundness = 0.4;
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
		[self autoBadgeSizeWithAttributedString:badgeAttributedString];
	}
	return self;
}

// I recommend to use the allocator customBadgeWithString
- (id) initWithString:(NSString *)badgeString withScale:(CGFloat)scale withShining:(BOOL)shining
{
	self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
	if(self!=nil) {
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
        CGFloat sizeOfFont = [CustomBadge sizeOfFontForString:badgeString withScale:scale];
		self.badgeText = [[NSAttributedString alloc] initWithString:badgeString attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:sizeOfFont],
                                                                                  NSForegroundColorAttributeName: [UIColor whiteColor]}];
		self.badgeFrame = YES;
		self.badgeFrameColor = [UIColor whiteColor];
		self.badgeInsetColor = [UIColor redColor];
		self.badgeCornerRoundness = 0.4;
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
		[self autoBadgeSizeWithAttributedString:badgeText];
	}
	return self;
}

// I recommend to use the allocator customBadgeWithString
- (id) initWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining 
{
	self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
	if(self!=nil) {
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
        CGFloat sizeOfFont = [CustomBadge sizeOfFontForString:badgeString withScale:scale];
		self.badgeText = [[NSAttributedString alloc] initWithString:badgeString attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:sizeOfFont],
                                                                                  NSForegroundColorAttributeName: stringColor}];
		self.badgeTextColor = stringColor;
		self.badgeFrame = badgeFrameYesNo;
		self.badgeFrameColor = frameColor;
		self.badgeInsetColor = insetColor;
		self.badgeCornerRoundness = 0.40;	
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
		[self autoBadgeSizeWithAttributedString:badgeText];
	}
	return self;
}


// Use this method if you want to change the badge text after the first rendering
- (void) autoBadgeSizeWithString:(NSString *)badgeString
{
    CGFloat sizeOfFont = [CustomBadge sizeOfFontForString:badgeString withScale:badgeScaleFactor];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:badgeString attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:sizeOfFont],
                                                                                                    NSForegroundColorAttributeName: badgeTextColor}];
    [self autoBadgeSizeWithAttributedString:attributedString];
}

- (void) autoBadgeSizeWithAttributedString:(NSAttributedString *)badgeAttributedString
{
	CGSize retValue;
	CGFloat rectWidth, rectHeight;
	CGSize stringSize = [badgeAttributedString.string sizeWithFont:[UIFont boldSystemFontOfSize:12]];
	CGFloat flexSpace;
	if ([badgeAttributedString.string length]>=2) {
		flexSpace = [badgeAttributedString.string length];
		rectWidth = 25 + (stringSize.width + flexSpace); rectHeight = 25;
		retValue = CGSizeMake(rectWidth*badgeScaleFactor, rectHeight*badgeScaleFactor);
	} else {
		retValue = CGSizeMake(25*badgeScaleFactor, 25*badgeScaleFactor);
	}
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, retValue.width, retValue.height);
    self.badgeText = badgeAttributedString;
    self.hidden = !badgeText.length;
	[self setNeedsDisplay];
}

- (void) autoBadgeSizeWithNumber1:(NSNumber *)number1 andNumber2:(NSNumber *)number2
{
    NSString *string = number1 ? (number2 ? [NSString stringWithFormat:@"%@ | %@", number1, number2] : number1.stringValue) : (number2 ? number2.stringValue: @"");
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:[CustomBadge sizeOfFontForString:string withScale:1]], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.badgeNumber1Color range:NSMakeRange(0, number1.stringValue.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.badgeNumber2Color range:NSMakeRange(number1 ? number1.stringValue.length + 3 : 0, number2.stringValue.length)];
    [self autoBadgeSizeWithAttributedString:attributedString];
}


+ (CustomBadge*) customBadgeWithAttributedString:(NSAttributedString *)badgeAttributedString
{
    return [[self alloc] initWithAttributedString:badgeAttributedString withScale:1.0 withShining:YES];
}

// Creates a Badge with a given Text 
+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString
{
	return [[self alloc] initWithString:badgeString withScale:1.0 withShining:YES];
}


// Creates a Badge with a given Text, Text Color, Inset Color, Frame (YES/NO) and Frame Color 
+ (CustomBadge*) customBadgeWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining
{
	return [[self alloc] initWithString:badgeString withStringColor:stringColor withInsetColor:insetColor withBadgeFrame:badgeFrameYesNo withBadgeFrameColor:frameColor withScale:scale withShining:shining];
}


+ (CustomBadge*) customBadgeWithNumber1:(NSNumber *)number1 number1Color:(UIColor *)color1 andNumber2:(NSNumber *)number2 number2Color:(UIColor *)color2
{
    NSString *string = number1 ? (number2 ? [NSString stringWithFormat:@"%@ | %@", number1, number2] : number1.stringValue) : (number2 ? number2.stringValue: @"");
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:[CustomBadge sizeOfFontForString:string withScale:1]], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, number1.stringValue.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(number1 ? number1.stringValue.length + 3 : 0, number2.stringValue.length)];
    CustomBadge *customBadge = [[CustomBadge alloc] initWithAttributedString:attributedString.copy withScale:1 withShining:YES];
    customBadge.badgeNumber1Color = color1;
    customBadge.badgeNumber2Color = color2;
    return customBadge;
}
 

// Draws the Badge with Quartz
-(void) drawRoundedRectWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);
	
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
		
    CGContextBeginPath(context);
	CGContextSetFillColorWithColor(context, [self.badgeInsetColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 3, [[UIColor blackColor] CGColor]);
    CGContextFillPath(context);

	CGContextRestoreGState(context);

}

// Draws the Badge Shine with Quartz
-(void) drawShineWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);
 
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
	CGContextBeginPath(context);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextClip(context);
	
	
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 0.4 };
	CGFloat components[8] = {  0.92, 0.92, 0.92, 1.0, 0.82, 0.82, 0.82, 0.4 };

	CGColorSpaceRef cspace;
	CGGradientRef gradient;
	cspace = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents (cspace, components, locations, num_locations);
	
	CGPoint sPoint, ePoint;
	sPoint.x = 0;
	sPoint.y = 0;
	ePoint.x = 0;
	ePoint.y = maxY;
	CGContextDrawLinearGradient (context, gradient, sPoint, ePoint, 0);
	
	CGColorSpaceRelease(cspace);
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);	
}


// Draws the Badge Frame with Quartz
-(void) drawFrameWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGFloat radius = CGRectGetMaxY(rect)*self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
	
	
    CGContextBeginPath(context);
	CGFloat lineSize = 2;
	if(self.badgeScaleFactor>1) {
		lineSize += self.badgeScaleFactor*0.25;
	}
	CGContextSetLineWidth(context, lineSize);
	CGContextSetStrokeColorWithColor(context, [self.badgeFrameColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextClosePath(context);
	CGContextStrokePath(context);
}


- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawRoundedRectWithContext:context withRect:rect];
	
	if(self.badgeShining) {
		[self drawShineWithContext:context withRect:rect];
	}
	
	if (self.badgeFrame)  {
		[self drawFrameWithContext:context withRect:rect];
	}
	
	if ([self.badgeText length]>0) {
		CGSize textSize = self.badgeText.size;
		[self.badgeText drawAtPoint:CGPointMake((rect.size.width/2-textSize.width/2), (rect.size.height/2-textSize.height/2))];
	}
	
}



@end
