//
//  VenueRatingView.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueRatingView.h"

@interface VenueRatingView ()

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) UIColor* color;
@property (strong, nonatomic) NSArray *ratingArray;

#define MAX_VENUE_RATING 10.0f
#define RADIANS_PER_DEGREE 0.0174532925f

@end

@implementation VenueRatingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initRatingThresholds];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initRatingThresholds];
    }
    return self;
}

- (void)initRatingThresholds {
    if (self.ratingArray == nil)
        self.ratingArray = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Venue rating"];
}

- (void)setRating:(NSNumber*) score {
    float scoreValue = [score floatValue];
    if (scoreValue < 0.0f) {
        self.color = nil;
        self.ratingLabel.text = @"N/A";
    } else {
        // color goes from bright green to red depending on venue rating
        float colorValue = scoreValue / MAX_VENUE_RATING;
        self.color = [UIColor colorWithRed:(1.0f - colorValue) green:colorValue blue:0.0f alpha:1.0f];
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", scoreValue];
    }
    // force redraw
    [self setNeedsDisplay];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawCircleInRect:rect inContext:context];
}

- (void)drawCircleInRect:(CGRect)rect inContext:(CGContextRef)context {
    CGFloat radius = rect.size.width/2;
    CGFloat start = 0 * RADIANS_PER_DEGREE;
    CGFloat end = 360 * RADIANS_PER_DEGREE;
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, rect.size.height);
    
    //define grayscale gradient
    CGFloat cc[] =
    {
        .70,.7,.7,1,  //r,g,b,a of color1, as a percentage of full on.
        .4,.4,.4,1,  //r,g,b,a of color2, as a percentage of full on.
    };
    
    //set up our gradient
    CGGradientRef gradient;
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(rgb, cc, NULL, sizeof(cc)/(sizeof(cc[0])*4));
    CGColorSpaceRelease(rgb);
    
    //draw the gradient on the sphere
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, radius, start, end, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextAddRect(context, rect);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    
    //now add our primary color.
    UIColor *color = self.color;
    [color setFill];
    CGContextSetBlendMode(context, kCGBlendModeColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

@end
