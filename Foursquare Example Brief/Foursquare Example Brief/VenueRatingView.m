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
    float colorValue = scoreValue / MAX_VENUE_RATING;
    self.color = [UIColor colorWithRed:(1.0f - colorValue) green:colorValue blue:0.0f alpha:1.0f];
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", scoreValue];
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
    CGFloat lineWidth = 1;
    CGRect borderRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);
}

@end
